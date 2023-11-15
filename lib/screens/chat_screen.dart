import 'package:chat_app/blocs/groups/group_cubit.dart';
import 'package:chat_app/comps/group_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

}
class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    GroupCubit.get(context).getUserData();
    super.initState();
  }
  String? groupName;
  @override
  Widget build(BuildContext context) {
    var gCubit=GroupCubit.get(context);
    var cCubit=ChatCubit.get(context);
    Map<String,String>groupNameMap;
    return BlocConsumer<GroupCubit, GroupState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chat Rooms",
          style:
              TextStyle(color:Color(0xffff4040), fontWeight: FontWeight.bold),
        ),
        shadowColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GroupList(groupStream:gCubit.groupStream),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
      showDialog(context: context, builder: (context){
        return AlertDialog(title: Text("Create a Group"),
          content:Column(mainAxisSize: MainAxisSize.min,
            children: [
            TextField(
            onChanged:(value){
              groupName=value;
            },)
          ],
          ),actionsAlignment: MainAxisAlignment.spaceBetween,actions: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("Close"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))),
            ElevatedButton(onPressed: (){
              if(groupName!=""){
                gCubit.createGroup(groupNameMap={
                  "groupName":groupName!
                });
                Navigator.of(context).pop();
                cCubit.showSnackBar(context, "group created");
              }
            }, child: Text("Create"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)))
          ],
        );
          }
          );
          },
          child: Icon(Icons.add, size: 36),
          backgroundColor: Color(0xffff4040)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  },
);
  }
}
