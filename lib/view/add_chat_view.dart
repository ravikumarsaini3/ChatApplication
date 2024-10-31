import 'dart:io';

import 'package:chat/utilities/custombutton/customelevatedbutton.dart';
import 'package:chat/utilities/utils.dart';
import 'package:flutter/material.dart';

import '../firebase_service/chat_service/chat_service.dart';

class AddChatView extends StatefulWidget {
  const AddChatView({super.key});

  @override
  State<AddChatView> createState() => _AddChatViewState();
}

class _AddChatViewState extends State<AddChatView> {
  bool loading = false;
  var namecontroller = TextEditingController();
  var chatcontroller = TextEditingController();
  final NewchatService _newchatService = NewchatService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        centerTitle: true,
        title: const Text(
          'New Chat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextField(
                controller: chatcontroller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "What's in your mind ....",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Customelevatedbutton(
                loading: loading,
                title: 'Add Chat',
                onpressed: () async {
                  try {
                    setState(() {
                      loading = true;
                    });
                    await _newchatService.AddChat(namecontroller.text.trim(),
                        chatcontroller.text.trim(), context);
                  } on SocketException {
                    setState(() {
                      loading = false;
                    });

                    Utils.ShowFlutterTost('No internet');
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils.ShowFlutterTost(e.toString());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
