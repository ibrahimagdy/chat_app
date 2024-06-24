import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget{
  static const String id = 'login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Image.asset("assets/images/scholar.png"),
            const Text(
              "Scolar Chat",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'pacifico',
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const Spacer(flex: 2),
            const Row(
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const CustomTextFormField(hintText: 'Email'),
            const SizedBox(height: 6),
            const CustomTextFormField(hintText: 'Password'),
            const Spacer(flex: 1),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              height: 55,
              child: const Center(
                child: Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffbfe3dd)
                  ),
                ),

              ],
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }


}