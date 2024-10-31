import 'package:chat/firebase_service/chat_service/chat_service.dart';
import 'package:chat/utilities/utils.dart';
import 'package:chat/view/add_chat_view.dart';
import 'package:chat/view/auth_view/signup_view.dart';
import 'package:chat/widgets/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  var ref = FirebaseFirestore.instance.collection('chats');
  final NewchatService _newchatService = NewchatService();
  var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              auth.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupView(),
                  ));
            },
            child: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: _newchatService.getchat(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('error  : ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: const Text('No Chats Available'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    var name = data['name'];
                    var chat = data['chat'];
                    var documentid = data.id;
                    return Card(
                      color: Colors.grey.shade100,
                      child: ListTile(
                        title: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          chat,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        ),
                        trailing: PopupMenuButton<String>(
                          iconSize: 20,
                          color: Colors.white,
                          onSelected: (value) {
                            if (value == 'delete') {
                              ref.doc(documentid).delete();
                              Utils.ShowFlutterTost('chat deleted');
                            } else if (value == 'update') {
                              print("Option 2 selected");
                              Update.showdilog(context, name, chat, documentid);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    Text('Delete'),
                                  ],
                                )),
                            const PopupMenuItem(
                                value: 'update',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    Text('Update'),
                                  ],
                                )),
                          ],
                          icon: const Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddChatView(),
              ));
        },
        child: const Icon(Icons.add_comment_sharp),
      ),
    );
  }
}
