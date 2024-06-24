import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/view/login_screen.dart';

class SplashScreen extends StatefulWidget{
  static const String id = 'splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Image.asset("assets/images/scholar.png"),
      ),
    );
  }
}