import 'package:flutter/material.dart';

class Customelevatedbutton extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;
  final bool loading;
  const Customelevatedbutton(
      {super.key,
      required this.title,
      required this.onpressed,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;
    var width = MediaQuery.of(context).size.width * 1;
    return ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade900,
            foregroundColor: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            fixedSize: Size(width * 0.8, height * 0.068)),
        child: loading
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ));
  }
}
