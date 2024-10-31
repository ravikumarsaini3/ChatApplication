import 'package:flutter/material.dart';

class Customtextbutton extends StatelessWidget {
  final VoidCallback onpressed;
  final String title;
  const Customtextbutton(
      {super.key, required this.onpressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onpressed, child: Text(title));
  }
}
