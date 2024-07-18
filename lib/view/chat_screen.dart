import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/chat_bubble.dart';
import 'package:scholar_chat/core/widgets/opposite_chat_bubble.dart';
import 'package:scholar_chat/model/message_model.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
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
                    reverse: true,
                      controller: scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messagesList[index].id == email
                            ? ChatBubble(message: messagesList[index])
                            : OppositeChatBubble(message: messagesList[index]);
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
                          focusNode: focusNode,
                          onFieldSubmitted: (data) {
                            messages.add({
                              'message': data,
                              'CreatedAt': DateTime.now(),
                              'id' : email,
                            });
                            controller.clear();
                            scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                            FocusScope.of(context).requestFocus(focusNode);
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
