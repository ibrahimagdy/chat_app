import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget{
  static const String id = 'HomeScreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
    );
  }

}