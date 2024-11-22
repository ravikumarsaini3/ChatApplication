import 'dart:async';

import 'package:chat/view/auth_view/signup_view.dart';

import 'package:chat/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashservice {
  var auth = FirebaseAuth.instance;

  void islogin(context) {
    var user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 4),
        () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const HomeView();
            },
          ));
        },
      );
    } else {
      Timer(
        const Duration(seconds: 4),
        () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const SignupView();
            },
          ));
        },
      );
    }
  }
}
