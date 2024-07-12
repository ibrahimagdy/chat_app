import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextFormField({Key? key, required this.hintText, required this.controller, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
        validator: validator,
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