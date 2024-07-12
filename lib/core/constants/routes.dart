import 'package:flutter/cupertino.dart';
import 'package:scholar_chat/view/login_screen.dart';
import 'package:scholar_chat/view/splash_screen.dart';
import '../../view/home_screen.dart';
import '../../view/register_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.id : (context) => const SplashScreen(),
  LoginScreen.id : (context) => const LoginScreen(),
  RegisterScreen.id : (context) => const RegisterScreen(),
  HomeScreen.id : (context) => const HomeScreen(),
};