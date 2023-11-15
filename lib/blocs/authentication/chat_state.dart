part of 'chat_cubit.dart';
@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class RegisterLoadingState extends ChatState {}
class RegisterSuccessState extends ChatState {}
class RegisterErrorState extends ChatState {
  final error;
  RegisterErrorState(this.error);
}
class LoginLoadingState extends ChatState {}
class LoginSuccessState extends ChatState {}
class LoginErrorState extends ChatState {
  final error;

  LoginErrorState(this.error);
}