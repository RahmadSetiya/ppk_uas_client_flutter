import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '../api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final fullname = TextEditingController();
  final pass_confirm = TextEditingController();
  bool _isObsecurePass = true;
  bool _isObsecurePassConfirm = true;
  var response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
                controller: fullname,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                controller: username,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: email,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isObsecurePass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObsecurePass = !_isObsecurePass;
                      });
                    },
                  ),
                ),
                obscureText: _isObsecurePass,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: TextField(
                controller: pass_confirm,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(_isObsecurePassConfirm
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObsecurePassConfirm = !_isObsecurePassConfirm;
                      });
                    },
                  ),
                ),
                obscureText: _isObsecurePassConfirm,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                response = await Network().register(
                  fullname.text,
                  username.text,
                  email.text,
                  password.text,
                  pass_confirm.text,
                );

                if (response['status'] == 201) {
                  var snackBar = SnackBar(
                    content: Text('Register Success'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                } else {
                  // json to list of string
                  var errors = response['messages'].values.toList();
                  // join list of string to string
                  var error = errors.join('\n');
                  //show alert dialog with error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(error),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
