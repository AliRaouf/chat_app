import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context)=>BlocProvider.of(context);
  Map<String,String>?userEmail;
  registerUser(String email,String password)
  {
    emit(RegisterLoadingState());
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
          saveUser(userEmail={
            "email":email
          });
      emit(RegisterSuccessState());
    }).catchError((error){
      emit(RegisterErrorState(error));
    });
  }
  loginUser(String email,String password)
  {
    emit(RegisterLoadingState());
    FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: password
    ).then((value){
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error));
    });
  }
  saveUser(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
showSnackBar(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
}
