import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final String hintText;
  const CustomTextFormField({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
        )
    );
  }
  OutlineInputBorder buildBorder(){
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );
  }
}