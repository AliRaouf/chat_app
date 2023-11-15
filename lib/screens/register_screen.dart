import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/blocs/authentication/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../comps/app_navigator.dart';
import '../comps/custom_button.dart';
import '../comps/custom_text_field.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool _isPasswordObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    var cubit=ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatState>(
  listener: (context, state) {
    if(state is RegisterSuccessState){
      cubit.showSnackBar(context, "Welcome To ChatFire");
      AppNavigator.customNavigator(
          context: context, screen: ChatScreen(), finish: true);
    }else if(state is RegisterErrorState){
      cubit.showSnackBar(context, state.error.toString());
    }
  },
  builder: (context, state) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenwidth,
                    height: screenheight * 0.41,
                    child: const Image(
                        image: AssetImage("assets/images/chat_fire.png"),
                        fit: BoxFit.cover),
                  ),
                  Container(
                    width: screenwidth * 0.8,
                    margin: EdgeInsets.only(bottom: screenheight * 0.05),
                    child: CustomTextFormField(
                        hintText: "Email",
                        labelText: "Email",
                        obscureText: false,
                        onchanged: (value) {
                          email = value;
                          print(email);
                        }),
                  ),
                  Container(
                    width: screenwidth * 0.8,
                    child: CustomTextFormField(
                      hintText: "Password",
                      labelText: "Password",
                      obscureText: _isPasswordObscured,
                      onchanged: (value) {
                        password = value;
                        print(password);
                      },
                      icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _togglePasswordVisibility();
                            });
                          },
                          icon: Icon(_isPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      iconColor: _isPasswordObscured ? Colors.red : Colors.grey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenheight * 0.07, bottom: screenheight * 0.02),
                    child: CustomButton(
                      screenwidth: screenwidth,
                      screenheight: screenheight,
                      text: "Sign Up",
                      onpressed: (){
                          cubit.registerUser(email!, password!);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you already have an account",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xffFF0000),
                          ),
                        ),
                        style:
                            ButtonStyle(visualDensity: VisualDensity.compact),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  },
);
  }
}
