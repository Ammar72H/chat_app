import 'package:chat_app/base.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/room.dart';
import 'package:chat_app/modules/chat/chat_navegator.dart';
import 'package:chat_app/modules/chat/chat_view_model.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class chatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends BaseState<chatScreen, ChatViewModel>
    implements ChatNavegator {
  var messageContentController = TextEditingController();
  String messageContent = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = room;
    viewModel.currentUser = provider.user!;
    viewModel.listenToUpdatesMessages();
    return Stack(children: [
      Container(
        child: Image.asset(
          'assets/images/main_bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(room.title),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.listenToUpdatesMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      var message = snapshot.data?.docs
                          .map((mess) => mess.data())
                          .toList();
                      return ListView.builder(
                          itemCount: message?.length ?? 0,
                          itemBuilder: (context, index) {
                            return MessageWidget(message![index]);
                          });
                    }),
              )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (text) {
                          messageContent = text;
                        },
                        controller: messageContentController,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        decoration: InputDecoration(
                            hintText: 'Type A Message',
                            // contentPadding: EdgeInsets.all( 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        viewModel.addMessageToChat(messageContent);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue),
                        child: Row(
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  ChatViewModel initalViewModel() => ChatViewModel();

  @override
  void clearForm() {
    messageContentController.clear();
  }
}
