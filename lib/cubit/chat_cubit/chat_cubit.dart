import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/model/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<MessageModel> messageList = [];
  void sendMessage({required String data, required String email}) {
    try {
      messages.add({
        'message': data,
        'CreatedAt': DateTime.now(),
        'id': email,
      });
    } catch (e) {

    }
  }

  void getMessage() {
    messages.orderBy('CreatedAt', descending: true).snapshots().listen((e) {
      messageList.clear();
        for (var doc in e.docs) {
          messageList.add(MessageModel.fromJson(doc));
        }
        emit(ChatSuccess(messages: messageList));
      },
    );
  }
}
