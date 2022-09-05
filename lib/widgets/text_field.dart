// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPassword;
  final TextInputAction textInputAction;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    this.isPassword = false,
    required this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPassword,
      textInputAction: textInputAction,
    );
  }
}
