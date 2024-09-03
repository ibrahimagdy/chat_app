import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is AuthLogin){
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
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
      else if(event is AuthRegister){
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure("The password provided is too weak"));
          }
          else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure("The account already exists for that email"));
          }
        } catch (ex) {
          emit(RegisterFailure(ex.toString()));
        }
      }
    });
  }
}
