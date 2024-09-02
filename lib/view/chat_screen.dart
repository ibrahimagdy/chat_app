import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/chat_bubble.dart';
import 'package:scholar_chat/core/widgets/opposite_chat_bubble.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';

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
  final scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
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
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList = BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return messagesList[index].id == email
                          ? ChatBubble(message: messagesList[index])
                          : OppositeChatBubble(message: messagesList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    onFieldSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(data: data, email: email);
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
                      suffixIcon: const Icon(Icons.send, color: primaryColor),
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

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: primaryColor,
      ),
    );
  }
}
