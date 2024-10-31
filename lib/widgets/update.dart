import 'package:chat/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update {
  static Future showdilog(context, name, chat, id) async {
    var ref = FirebaseFirestore.instance.collection('chats');
    var namecontroller = TextEditingController();
    var chatcontroller = TextEditingController();
    namecontroller.text = name;
    chatcontroller.text = chat;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 124,
            child: Column(
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.green)),
                      labelText: 'name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: chatcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.green)),
                      labelText: 'Chat'),
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.doc(id).update({
                        'name': namecontroller.text,
                        'chat': chatcontroller.text,
                      });
                      Utils.ShowFlutterTost('Updated');
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'cancle',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ))
              ],
            )
          ],
        );
      },
    );
  }
}
