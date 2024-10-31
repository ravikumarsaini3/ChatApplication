import 'package:chat/utilities/utils.dart';
import 'package:chat/view/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ASignupService {
  var auth = FirebaseAuth.instance;
  Future SignupService(String email, String password, context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          Utils.ShowFlutterTost('Account Create Successfully');
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
