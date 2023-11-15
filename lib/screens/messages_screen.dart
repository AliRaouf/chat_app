import 'package:chat_app/blocs/message/message_cubit.dart';
import 'package:flutter/material.dart';

import '../comps/chat_list.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen(
      {super.key, required this.groupName, required this.userMail});

  final String groupName;
  final String userMail;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();

}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    MessageCubit.get(context).getUserData();
    MessageCubit.get(context).receiveMessage(widget.groupName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var mCubit = MessageCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff4040),
        title: Text("${widget.groupName}"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          mCubit.messagesStream != null // Check if messagesStream is not null
              ? ChatList(
            messageStream: mCubit.messagesStream!,
            userMail: mCubit.user!.email!,
          )
              : CircularProgressIndicator(),
          // Show CircularProgressIndicator if messagesStream is null
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.95,
                child: TextFormField(
                  controller: messageController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        DateTime time = DateTime.now();
                        mCubit.sendMessage(
                          messageController.text,
                          time,
                          widget.groupName,
                        );
                        messageController.clear();
                      },
                      icon: Icon(Icons.send, color: Color(0xffff4040)),
                    ),
                    hintText: 'Send a Message',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
