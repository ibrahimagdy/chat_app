import 'package:flutter/material.dart';
import 'package:scholar_chat/model/message_model.dart';
import '../constants/theme.dart';

class ChatBubble extends StatelessWidget{
  final MessageModel message;
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 20),
        padding: const EdgeInsets.only(left: 12, right: 15, bottom: 20, top: 20),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(18),
            topRight: Radius.circular(18),
            topLeft: Radius.circular(22),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

}