import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, Color barColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: barColor,
      content: Text(message, style: const TextStyle(color: Colors.white)),
    ),
  );
}