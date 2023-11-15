import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  static MessageCubit get(context)=>BlocProvider.of(context);
  String? userEmail;
  Stream ?messagesStream;
  User? user;
  sendMessage(String text,DateTime time, String groupName){
  userEmail=FirebaseAuth.instance.currentUser!.email;
  emit(MessageSendLoadingState());
  Message message= Message(text: text, time: DateTime.now(), sender: userEmail!, groupName:groupName);
  FirebaseFirestore.instance.collection("messages").add(message.toMap()).
  then((value){
    emit(MessageSendSuccessState());
  }).
  catchError((error) {
    emit(MessageSendErrorState()
    );
    print(error);
  });
  }
  receiveMessage(String groupName){
    messagesStream=FirebaseFirestore.instance.collection("messages").where("groupName",isEqualTo:groupName).orderBy("time").snapshots();
  emit(MessageReceiveMessageState());
  }
  getUserData()
  {
    user=FirebaseAuth.instance.currentUser;
    emit(MessageGetUserDataState());
  }
}
