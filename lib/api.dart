import 'dart:convert';
import 'dart:io';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  var token;

  register(String fullname, String username, String email, String password,
      String pass_confirm) async {
    var url = Uri.parse('https://uas-ppk-api.000webhostapp.com/register');
    print(url);

    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'fullname': fullname,
          'username': username,
          'email': email,
          'password': password,
          'pass_confirm': pass_confirm
        }));

    var data;
    var message;
    if (response.statusCode == 201) {
      data = jsonDecode(response.body);
      return data;
    } else {
      data = jsonDecode(response.body);
      print(data);
      return data;
    }
  }

  login(String username, String password) async {
    var url = Uri.parse('https://uas-ppk-api.000webhostapp.com/login');
    var response = await http.post(url, headers: {
      // content x-www-form-urlencoded
      'Content-Type': 'application/x-www-form-urlencoded',
    }, body: {
      'username': username,
      'password': password
    });

    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      token = data['data']['token'];
    } else {
      data = jsonDecode(response.body);
      return data['message'];
    }

    if (response.statusCode == 200) {
      var session = SessionManager();
      await session.set('user_id', data['data']['user_id']);
      await session.set('fullname', data['data']['fullname']);
      await session.set('username', data['data']['username']);
      await session.set('email', data['data']['email']);
      await session.set('role', data['data']['role']);
      await session.set('token', data['data']['token']);
      await session.set('isLogin', true);

      return response.statusCode;
    }
  }

  logout() async {
    var url = Uri.parse('https://uas-ppk-api.000webhostapp.com/logout');

    var session = SessionManager();
    await session.remove('user_id');
    await session.remove('fullname');
    await session.remove('username');
    await session.remove('email');
    await session.remove('role');
    await session.remove('token');
    await session.remove('isLogin');

    var response = await http.get(url);
    return response.statusCode;
  }

  edit_user(String username, String fullname, String email, String password,
      String pass_confirm) async {
    var session = SessionManager();
    var id = await session.get('user_id');
    String token = await session.get('token');
    var url = Uri.parse(
        'https://uas-ppk-api.000webhostapp.com/api/user/update/' +
            id.toString());

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${token}',
      },
      body: {
        'username': username,
        'fullname': fullname,
        'email': email,
        'password': password,
        'pass_confirm': pass_confirm
      },
    );

    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      await session.set('fullname', data['fullname']);
      await session.set('username', data['username']);
      await session.set('email', data['email']);
      await session.set('password', data['password']);
      await session.set('pass_confirm', data['pass_confirm']);
      data['status'] = 200;

      print(data);
      return data;
    } else {
      data = jsonDecode(response.body);
      return data;
    }
  }
}
