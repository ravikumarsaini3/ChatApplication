import 'package:chat/firebase_service/auth_service/signup_service.dart';
import 'package:chat/utilities/custombutton/customelevatedbutton.dart';
import 'package:chat/utilities/custombutton/customtextbutton.dart';
import 'package:chat/view/auth_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  var auth = FirebaseAuth.instance;
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
                  'Welcome',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w800,
                      fontSize: 25),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                const Text(
                  'Create New Account',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: height * 0.04,
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
                  height: height * 0.01,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      prefixIcon: Icon(Icons.account_circle)),
                ),
                SizedBox(
                  height: height * 0.01,
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
                SizedBox(
                  height: height * 0.1,
                ),
                Customelevatedbutton(
                    title: 'Signup',
                    onpressed: () {
                      ASignupService Signup = ASignupService();
                      Signup.SignupService(emailcontroller.text.trim(),
                          mobilecontroller.text, context);
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                Customtextbutton(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ));
                    },
                    title: 'Already Have An Account   Login?')
              ],
            ),
          )),
        ),
      ),
    );
  }
}
