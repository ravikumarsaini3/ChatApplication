import 'package:chat/utilities/utils.dart';

import 'package:chat/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ALoginService extends GetxController {
  var auth = FirebaseAuth.instance;

  Future<void> loginService(String email, String password,
      {required Function onSuccess}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          Utils.ShowFlutterTost('Login Successful');
          onSuccess();
          Get.to(() => const HomeView());
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
