import 'package:chat/firebase_service/auth_service/login_service.dart';
import 'package:chat/utilities/custombutton/customelevatedbutton.dart';
import 'package:chat/utilities/custombutton/customtextbutton.dart';
import 'package:chat/view/auth_view/signup_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ALoginService _loginservice = ALoginService();
  var emailcontroller = TextEditingController();
  var mobilecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        title: const Text(
          'Chat Application',
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
                  controller: emailcontroller,
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
                  keyboardType: TextInputType.phone,
                  controller: mobilecontroller,
                  decoration: const InputDecoration(
                      labelText: 'mobile',
                      hintText: 'Enter mobile number',
                      prefixIcon: Icon(Icons.call)),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Customelevatedbutton(
                    title: 'Login',
                    onpressed: () {
                      _loginservice.LoginService(
                          emailcontroller.text, mobilecontroller.text, context);
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                Customtextbutton(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupView(),
                          ));
                    },
                    title: 'if you have no account  Signup?')
              ],
            ),
          )),
        ),
      ),
    );
  }
}
