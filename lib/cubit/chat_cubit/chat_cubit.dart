import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/model/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  void sendMessage({required String data, required String email}) {
    messages.add({
      'message': data,
      'CreatedAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    List<MessageModel> messageList = [];
    messages.orderBy('CreatedAt', descending: true).snapshots().listen((e) {
        for (var doc in e.docs) {
          messageList.add(MessageModel.fromJson(doc));
        }
      },
    );
  }
}
