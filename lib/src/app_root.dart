import 'package:chat_app/blocs/authentication/chat_cubit.dart';
import 'package:chat_app/blocs/message/message_cubit.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/groups/group_cubit.dart';
import '../screens/register_screen.dart';
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ChatCubit()),
        BlocProvider(create: (context)=>MessageCubit()),
        BlocProvider(create: (context)=>GroupCubit()..receiveGroups()
        )
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
