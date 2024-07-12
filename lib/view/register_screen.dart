import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/view/login_screen.dart';
import '../core/helpers/show_snackbar.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    "Scolar Chat",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'pacifico',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: mediaQuery.height * 0.1),
                  const Row(
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                        isAsyncCall = true;
                        setState(() {
                        });
                        signUp();
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
                          'Sign Up',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffbfe3dd)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackBar(context, "Success Sign up, Let's Login", Colors.green);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.", Colors.red);
      }
      else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.", Colors.red);
      }
    } catch (ex) {
      showSnackBar(context, ex.toString(), Colors.red);
    }
    isAsyncCall = false;
    setState(() {

    });
  }
}
