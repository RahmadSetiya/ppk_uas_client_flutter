import 'package:flutter/material.dart';
import 'Auth/login.dart';
import 'User/user_detail.dart';
import 'api.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Icon(
              Icons.account_circle,
              size: 100,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Network().logout();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
              title: Text('Copyright by Rahmad Setiya Budi'),
            ),
          )
        ],
      ),
    );
  }
}
