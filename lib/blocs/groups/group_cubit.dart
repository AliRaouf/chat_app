import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());
  static GroupCubit get(context)=>BlocProvider.of(context);
  Stream? groupStream;
  String? groupName;
  User? user;
  createGroup(nameMap){
    FirebaseFirestore.instance.collection("groups").add(nameMap);
  }
  receiveGroups(){
    groupStream=FirebaseFirestore.instance.collection("groups").snapshots();
  }
  getUserData()
  {
    user=FirebaseAuth.instance.currentUser;
  }
}
