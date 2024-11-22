import 'package:chat/firebase_service/auth_service/login_service.dart';
import 'package:chat/utilities/custombutton/customelevatedbutton.dart';
import 'package:chat/utilities/custombutton/customtextbutton.dart';
import 'package:chat/view/auth_view/signup_view.dart';
import 'package:chat/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(ALoginService());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w800,
                        fontSize: 25),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Text(
                    'Login Your Account',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter Email',
                        prefixIcon: Icon(Icons.email)),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock)),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Customelevatedbutton(
                    title: 'Login',
                    onpressed: () {
                      loginController.loginService(
                        emailController.text,
                        passwordController.text,
                        onSuccess: () {
                          _saveUser(emailController.text);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Customtextbutton(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                    title: 'If you have no account Signup?',
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Customelevatedbutton(
                    title: 'Saved Users',
                    onpressed: () {
                      _showSavedUsersDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Save the logged-in user to local storage
  void _saveUser(String email) {
    List<dynamic> savedUsers = storage.read<List<dynamic>>('savedUsers') ?? [];
    if (!savedUsers.contains(email)) {
      savedUsers.add(email);
      storage.write('savedUsers', savedUsers);
    }
  }

  /// Show a list of saved users in a dialog
  void _showSavedUsersDialog(BuildContext context) {
    List<dynamic> savedUsers = storage.read<List<dynamic>>('savedUsers') ?? [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a User'),
          content: savedUsers.isEmpty
              ? const Text('No saved users found.')
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: savedUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(savedUsers[index]),
                        onTap: () {
                          Get.to(() => const HomeView());
                          // Close the dialog
                          _loginWithSavedUser(savedUsers[index]);
                        },
                      );
                    },
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// Log in with a saved user's email
  void _loginWithSavedUser(String email) {
    loginController.loginService(
      email,
      '', // Pass an empty password if Firebase allows single-factor authentication
      onSuccess: () {
        Get.to(() => const HomeView());
      },
    );
  }
}
