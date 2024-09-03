import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/bloc/auth_bloc.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  bool isAsyncCall = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          isAsyncCall = true;
        }
        else if(state is RegisterSuccess){
          isAsyncCall = false;
          showSnackBar(context, "Success Sign up, Let's Login", Colors.green);
          Navigator.pop(context);
        }
        else if(state is RegisterFailure){
          isAsyncCall = false;
          showSnackBar(context, state.errMessage, Colors.red);
        }
      },
      builder: (context, state) {
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
                        onChanged: (data){
                          email = data;
                        },
                        hintText: 'Email',
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must enter Email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 6),
                      CustomTextFormField(
                        onChanged: (data){
                          password = data;
                        },
                        hintText: 'Password',
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must enter Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: mediaQuery.height * 0.05),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(AuthRegister(email: email!, password: password!));
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
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
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
      },
    );
  }
}
