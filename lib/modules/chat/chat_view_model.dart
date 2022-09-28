import 'package:chat_app/base.dart';
import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/modules/chat/chat_navegator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/room.dart';

class ChatViewModel extends BaseViewModel<ChatNavegator> {
  late Room room;
  late MyUser currentUser;

  void addMessageToChat(String messageContent) async {
    Message message = Message(
        roomId: room.id,
        content: messageContent,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderId: currentUser.id,
        senderName: currentUser.username);
    try {
      var res = await DataBaseUtils.insertMessageToFireStore(message);
      navigator?.clearForm();
    } catch (e) {
      navigator?.showMessage(e.toString());
    }
  }

  Stream<QuerySnapshot<Message>> listenToUpdatesMessages() {
    return DataBaseUtils.getMessageStream(room.id);
  }
}
