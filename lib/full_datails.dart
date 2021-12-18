import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/api/User_api.dart';
import 'widgets/Textwidget.dart';

class FullUserDetail extends StatefulWidget {
  const FullUserDetail({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<FullUserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Container(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            provider.currentUser!.profileImage ??
                                'https://i.ibb.co/xfDG9kn/img.png',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(provider.currentUser!.name.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(provider.currentUser!.username.toString()),
                      SizedBox(height: 50),
                      TextFieldUser(
                        title: "Email",
                        value: provider.currentUser!.email.toString(),
                      ),
                      TextFieldUser(
                        title: "Address",
                        value:
                            "${provider.currentUser!.address!.city.toString()}\n${provider.currentUser!.address!.street.toString()}",
                      ),
                      TextFieldUser(
                        title: "Phone",
                        value: provider.currentUser!.phone.toString(),
                      ),
                      TextFieldUser(
                        title: "Company Details",
                        value:
                            "${provider.currentUser!.company!.name.toString()}\n${provider.currentUser!.company!.catchPhrase.toString()}\n${provider.currentUser!.company!.bs.toString()}",
                      ),
                      TextFieldUser(
                        title: "Website",
                        value: provider.currentUser!.website.toString(),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
