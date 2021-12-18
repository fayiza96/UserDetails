import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:user/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<User> users = [];
  Box? box;
  bool isLoading = false;
  User? currentUser;

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox("data");
    return;
  }

  setUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  getdata() async {
    isLoading = true;
    notifyListeners();
    await openBox();
    await getBoxdata();
    if (users.isEmpty) {
      http.Response response = await http.get(
        Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        await putdata(jsonDecode(response.body));
        await getBoxdata();
        // List temp = jsonDecode(response.body);
        // temp.forEach((element) {
        //   User usr = User.fromJson(element);
        //   users.add(usr);
        // });
        // print(users);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future putdata(data) async {
    await box!.clear();
    for (var d in data) {
      box!.add(d);
    }
  }

  Future getBoxdata() async {
    users = [];
    await openBox();
    var temp = box!.toMap().values.toList();
    temp.forEach((element) {
      User user = User.fromJson(element);
      users.add(user);
    });
    print(users[0].email);
    notifyListeners();
  }

  //   getfrienddata() async {
  //   users = [];
  //   http.Response response = await http.get(
  //     Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   ).timeout(Duration(seconds: 30));
  //   if (response.statusCode == 200) {
  //     List temp = jsonDecode(response.body);
  //     temp.forEach((element) {
  //       Friend frd = Friend.fromJson(element);
  //       friend.add(frd);
  //     });

  //   }
  // }
}
