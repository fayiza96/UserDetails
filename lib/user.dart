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
  String _searchText = "";
  bool isSearching = false;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Provider.of<UserProvider>(context, listen: false).getdata();
    });
    super.initState();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        isSearching = true;
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onChanged: (val) {
            context.read<UserProvider>().searchData(val);
          },
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            hintText: 'Search user by name',
            hintStyle: TextStyle(color: Colors.grey[100]),
          ),
        );
      } else {
        isSearching = false;
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Users');
      }
    });
  }

  @override
  void dispose() {
    Hive.close();
    // TODO: implement dispose
    super.dispose();
  }

  _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return isSearching
                  ? ListView.builder(
                      itemCount: provider.searchedUsers.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () {
                              provider.setUser(provider.searchedUsers[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullUserDetail()));
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${provider.searchedUsers[index].profileImage ?? 'https://i.ibb.co/xfDG9kn/img.png'}"),
                            ),
                            title:
                                Text("${provider.searchedUsers[index].name}"),
                            subtitle: Text(
                                "${provider.searchedUsers[index].company?.name}"));
                      },
                    )
                  : ListView.builder(
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
                            subtitle:
                                Text("${provider.users[index].company?.name}"));
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
