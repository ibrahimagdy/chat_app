import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget{
  static const String id = 'HomeScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return const ChatBubble();
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(Icons.send, color: primaryColor),
                border: buildBorder(),
                enabledBorder: buildBorder(),
                focusedBorder: buildBorder(),
              ),
            ),
          ),
        ],
      ),
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