import '../api.dart';
import 'package:flutter/material.dart';
import '../dashboard.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();

  final password = TextEditingController();

  var response;

  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        //login
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //create form login
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              width: 300,
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObsecure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObsecure = !_isObsecure;
                      });
                    },
                  ),
                ),
                obscureText: _isObsecure,
              ),
              // add show password
            ),
            ElevatedButton(
              onPressed: () async {
                response = await Network().login(username.text, password.text);
                if (response.toString() == '200') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Dashboard(),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Login Failed'),
                        content: Text('Username or Password is incorrect'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                );
              },
              child: Text(' Does not have account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
