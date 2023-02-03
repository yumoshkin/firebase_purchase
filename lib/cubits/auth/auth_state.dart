part of 'auth_cubit.dart';

abstract class AuthState {
  User? get user;
  set user(User? user);
  String get message;
  set message(String message);
}

class AuthInitialState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
  AuthInitialState({this.user});
}

class AuthSuccessState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
  AuthSuccessState({this.user});
}

class AuthFailureState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
  AuthFailureState({required this.message});
}

class AuthSendEmailVerificationState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
}

class AuthResetPasswordState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
}

class AuthDisconnectState extends AuthState {
  @override
  User? user;
  @override
  String message = '';
}
