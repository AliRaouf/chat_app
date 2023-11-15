part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}
class MessageSendSuccessState extends MessageState {}
class MessageSendErrorState extends MessageState {}
class MessageSendLoadingState extends MessageState {}
class MessageReceiveMessageState extends MessageState {}
class MessageGetUserDataState extends MessageState {}
