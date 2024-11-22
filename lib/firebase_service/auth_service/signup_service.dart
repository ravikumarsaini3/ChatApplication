import 'package:chat/utilities/utils.dart';
import 'package:chat/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ASignupService extends GetxController {
  final auth = FirebaseAuth.instance;

  Future<void> signupService(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then(
        (value) {
          Utils.ShowFlutterTost('Account Created Successfully');
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
