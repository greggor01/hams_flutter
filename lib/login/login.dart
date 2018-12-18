import 'package:flutter/material.dart';
import 'dart:convert';

import '../api.dart';

class _LoginData {
  String username = '';
  String password = '';
}

class LoginFormState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _LoginData _data = _LoginData();

  doLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.
      var response = await Apis.login(_data.username, _data.password);
      // If the form is valid, we want to show a Snackbar
      if (response.statusCode == 200) {
        var parsedResponse = JsonDecoder().convert(response.body);
        Apis.setAuthHeader(parsedResponse['result']['token']);
        Navigator.pushNamed(context, '/inspections');
      } else {
        final snackBar = SnackBar(
            backgroundColor: Colors.red, content: Text('Invalid Login!'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Login"),
                TextFormField(
                    decoration: InputDecoration(labelText: 'User Name'),
                    onSaved: (String value) {
                      this._data.username = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a username';
                      }
                    }),
                TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (String value) {
                      this._data.password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a password';
                      }
                    }),
                RaisedButton(
                  onPressed: () {
                    doLogin();
                  },
                  child: Text('Login!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  LoginFormState createState() => new LoginFormState();
}
