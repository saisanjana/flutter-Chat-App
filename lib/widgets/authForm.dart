//import 'dart:html';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(String email, String username, String password, bool islogin,
      BuildContext ctx) submit;
  final bool isLoading;
  AuthForm(this.submit, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _username = '';
  var _password = '';
  void _submit() {
    final isvalid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      _formkey.currentState.save();
      widget.submit(
          _email.trim(), _username.trim(), _password.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (val) {
                      if (val.isEmpty || !val.contains('@')) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) {
                      _email = val;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (val) {
                        if (val.isEmpty || val.length < 4) {
                          return 'Enter atleast 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (val) {
                        _username = val;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 7) {
                        return 'Enter atleast 7 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (val) {
                      _password = val;
                    },
                  ),
                  SizedBox(height: 10),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: _submit,
                          child: Text(_isLogin ? 'Login' : 'Sign Up'),
                        ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'Already have account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
