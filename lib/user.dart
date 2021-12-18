import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:user/api/User_api.dart';
import 'package:user/full_datails.dart';
import 'widgets/Textwidget.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<UserProvider>(context, listen: false).getdata();
    });
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users")),
      body: Container(
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: provider.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {
                        provider.setUser(provider.users[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullUserDetail()));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${provider.users[index].profileImage ?? 'https://i.ibb.co/xfDG9kn/img.png'}"),
                      ),
                      title: Text("${provider.users[index].name}"),
                      subtitle: Text("${provider.users[index].company?.name}"));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
