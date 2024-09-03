part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogin extends AuthEvent{
  final String email, password;
  AuthLogin({required this.email,required this.password});
}

class AuthRegister extends AuthEvent{
  final String email, password;
  AuthRegister({required this.email,required this.password});
}
