import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/routes.dart';
import 'package:scholar_chat/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      routes: routes,
    );
  }

}