import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  
  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure("No user found for that email"));
      }
      else if (e.code == 'wrong-password') {
        emit(LoginFailure("Wrong password provided for that user"));
      }
      else {
        emit(LoginFailure("An unexpected error occurred"));
      }
    } catch (e) {
      emit(LoginFailure("Wrong Email or Password"));
    }
  }
}
