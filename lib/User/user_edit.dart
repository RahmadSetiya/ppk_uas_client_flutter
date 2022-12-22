import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:ppk_uas_client_flutter/dashboard.dart';
import '../sidebar.dart';
import '../api.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final username = TextEditingController();
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final pass_confirm = TextEditingController();

  bool _isObsecurePass = true;
  bool _isObsecurePassConfirm = true;

  var response;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
          ),
          drawer: const Sidebar(),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                    controller: fullname,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    controller: username,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: email,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //show dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    // ignore: prefer_const_constructors
                    title: Text('Save Changes'),
                    // ignore: prefer_const_constructors
                    content: Text('Are you sure you want to save changes?'),
                    actions: <Widget>[
                      TextButton(
                        // ignore: prefer_const_constructors
                        child: Text('Yes'),
                        onPressed: () async {
                          response = await Network().edit_user(
                              username.text,
                              fullname.text,
                              email.text,
                              password.text,
                              pass_confirm.text);
                          if (response['status'] == 200) {
                            var snackBar = SnackBar(
                              content: Text('Update Success'),
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            
                          } else {
                            var errors = response['messages'].values.toList();
                            var error = errors.join('\n');
                            Navigator.of(context).pop();
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
                      ),
                      TextButton(
                        // ignore: prefer_const_constructors
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.save),
          )),
    );
  }
}
