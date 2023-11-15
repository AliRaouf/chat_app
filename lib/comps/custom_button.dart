import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.screenwidth,
      required this.screenheight,
      required this.text,
      required this.onpressed});

  final double screenwidth;
  final double screenheight;
  final String text;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            fixedSize: MaterialStatePropertyAll(
              Size(screenwidth * 0.62, screenheight * 0.1),
            ),
            backgroundColor: MaterialStatePropertyAll(Color(0xffff4040))),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ));
  }
}
