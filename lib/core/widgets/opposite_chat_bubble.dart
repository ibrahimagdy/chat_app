import 'package:flutter/material.dart';
import '../../model/message_model.dart';

class OppositeChatBubble extends StatelessWidget{
  final MessageModel message;
  const OppositeChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 20),
        padding: const EdgeInsets.only(left: 12, right: 15, bottom: 20, top: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF314BAF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
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