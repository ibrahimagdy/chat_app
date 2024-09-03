import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/bloc/auth_bloc.dart';
import 'package:scholar_chat/core/constants/theme.dart';
import 'package:scholar_chat/core/widgets/custom_text_form_field.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/view/register_screen.dart';
import '../core/helpers/show_snackbar.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey <FormState> formKey = GlobalKey();
  bool isAsyncCall = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading){
          isAsyncCall = true;
        }
        else if(state is LoginSuccess){
          isAsyncCall = false;
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.pushReplacementNamed(context, ChatScreen.id, arguments: email);
          showSnackBar(context, "Success Login", Colors.green);
        }
        else if(state is LoginFailure){
          isAsyncCall = false;
          showSnackBar(context, state.errMessage, Colors.red);
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                      onChanged: (data){
                        email = data;
                      },
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
                      onChanged: (data){
                        password = data;
                      },
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
                          BlocProvider.of<AuthBloc>(context).add(AuthLogin(email: email!, password: password!));
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
      ),
    );
  }
}
