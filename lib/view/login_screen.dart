import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/view/register_screen.dart';

import '../core/services/show_snackbar.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey <FormState> formKey = GlobalKey();
  bool isAsyncCall = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isAsyncCall,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.height * 0.2),
                  Image.asset("assets/images/scholar.png"),
                  const Text(
                    "Scholar Chat",
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.1),
                  const Row(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mediaQuery.height * 0.02),
                  CustomTextFormField(
                    hintText: 'Email',
                    controller: emailController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'You must enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 6),
                  CustomTextFormField(
                    hintText: 'Password',
                    controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'You must enter Password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: mediaQuery.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      if(formKey.currentState!.validate()){
                        setState(() {
                          isAsyncCall = true;
                        });
                        login();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      height: 55,
                      child: const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffbfe3dd),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackBar(context, "Success Login", Colors.green);
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.", Colors.red);
      }
      else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user.", Colors.red);
      }
      else {
        showSnackBar(context, "Wrong Email or Password", Colors.red);
      }
    } catch (e) {
      showSnackBar(context, "An unexpected error occurred.", Colors.red);
    }
    setState(() {
      isAsyncCall = false;
    });
  }


}
