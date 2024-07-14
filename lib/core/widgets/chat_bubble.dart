import 'package:flutter/material.dart';
import '../constants/theme.dart';

class ChatBubble extends StatelessWidget{
  const ChatBubble({Key? key}) : super(key: key);

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
        child: const Text(
          'I am a New User ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

}