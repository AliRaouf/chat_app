import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  Function(String)? onchanged;
  String? hintText;
  String? labelText;
  bool? obscureText;
  IconButton? icon;
  Color? iconColor;

  CustomTextFormField(
      {super.key, this.icon,this.onchanged, this.hintText, this.labelText, this.obscureText, this.iconColor});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: false,
      obscureText: widget.obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required";
        }
      },
      onChanged: widget.onchanged,
      decoration: InputDecoration(constraints: const BoxConstraints(maxWidth: 300),
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Color(0xff535567),
              fontWeight: FontWeight.bold,
              fontSize: 20),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Color(0xffFF0000), style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Color(0xffFF0000),
                  style: BorderStyle.solid,
                  width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xffFF0000),style: BorderStyle.solid,
                  width: 2)
          ),suffixIcon: widget.icon,
        suffixIconColor: widget.iconColor
      ),
    );
  }
}
