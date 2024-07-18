import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/chat_bubble.dart';
import 'package:scholar_chat/model/message_model.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for(int i = 0; i < snapshot.data!.docs.length; i++){
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
         // print(snapshot.data!.docs[1]['message']);
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),
                  const Text('Scholar Chat'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: messagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatBubble(
                          message: messagesList[index],
                        );
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          onFieldSubmitted: (data) {
                            messages.add({
                              'message': data,
                              'CreatedAt' : DateTime.now(),
                            });
                            controller.clear();
                          },
                          decoration: InputDecoration(
                            hintText: 'Send Message',
                            suffixIcon:
                                const Icon(Icons.send, color: primaryColor),
                            border: buildBorder(),
                            enabledBorder: buildBorder(),
                            focusedBorder: buildBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor,
                        child: Icon(
                          CupertinoIcons.mic_fill,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text("Loading..."),
        );
      },
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: primaryColor,
      ),
    );
  }
}
