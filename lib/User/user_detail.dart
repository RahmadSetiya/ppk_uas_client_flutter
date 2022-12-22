import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../sidebar.dart';
import 'user_edit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: Sidebar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Full Name: '),
                Text('full name'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Username: '),
                Text('username'),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Email: '),
                Text('email'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileEdit(),
            ),
          );
        },
        child: Icon(Icons.edit),
      )
    );
  }
}