import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../widgets/authForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  void submitData(String email, String username, String password, bool islogin,
      BuildContext ctx) async {
    AuthResult _result;
    try {
      setState(() {
        isLoading = true;
      });
      if (islogin) {
        _result = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        _result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await Firestore.instance
            .collection('users')
            .document(_result.user.uid)
            .setData({
          'username': username,
          'email': email,
        });
      }
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (err) {
      var msg = 'Please check your creds!';
      if (err.message != null) {
        msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitData, isLoading),
    );
  }
}
