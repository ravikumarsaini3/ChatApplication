import 'package:chat/utilities/utils.dart';
import 'package:chat/view/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ALoginService {
  var auth = FirebaseAuth.instance;
  Future LoginService(String email, String password, context) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          Utils.ShowFlutterTost('Login Successfull');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatView(),
              ));
        },
      ).onError(
        (error, stackTrace) {
          Utils.ShowFlutterTost(error.toString());
        },
      );
    } catch (e) {
      Utils.ShowFlutterTost(e.toString());
    }
  }
}
