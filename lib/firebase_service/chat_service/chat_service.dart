import 'dart:io';

import 'package:chat/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewchatService {
  var ref = FirebaseFirestore.instance.collection('chats');
  String userid = DateTime.now().microsecondsSinceEpoch.toString();

  Stream<QuerySnapshot> getchat() {
    return ref
        .orderBy(
          "timestamp",
          descending: true,
        )
        .snapshots();
  }

  Future<dynamic> AddChat(String name, String chat, context) async {
    try {
      await ref.add({
        'userid': userid,
        'name': name,
        'chat': chat,
        'timestamp': FieldValue.serverTimestamp(),
      }).then(
        (value) {
          Utils.ShowFlutterTost('Chat Added');
          Navigator.pop(context);
        },
      ).onError(
        (error, stackTrace) {
          Utils.ShowFlutterTost(error.toString());
        },
      );
    } on SocketException {
      Utils.ShowFlutterTost('no internet ');
    } catch (e) {
      Utils.ShowFlutterTost(e.toString());
    }
  }
}
