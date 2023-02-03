import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthInitialState(user: FirebaseAuth.instance.currentUser));

  Future<bool> signin(
    String email,
    String password,
  ) async {
    var errorMessage = '';

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(AuthSuccessState(user: userCredential.user));
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'Этот адрес электронной почты не зарегистрирован';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Неправильный пароль';
      } else {
        errorMessage = e.message.toString();
      }

      emit(AuthFailureState(message: errorMessage));
      return false;
    }
  }

  Future<void> signup(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    UserCredential? userCredential;
    var errorMessage = '';

    if (password != passwordConfirmation) {
      errorMessage = 'Пароль и подтверждение пароля должны совпадать';
      emit(AuthFailureState(message: errorMessage));
      return;
    }
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        emit(AuthSuccessState(user: userCredential.user));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Этот адрес электронной почты уже зарегистрирован';
      } else {
        errorMessage = e.message.toString();
      }

      emit(AuthFailureState(message: errorMessage));
    }
  }

  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    emit(AuthSendEmailVerificationState());
  }

  Future<void> resetPassword(
    String email,
  ) async {
    var errorMessage = '';

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthResetPasswordState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'Этот адрес электронной почты не зарегистрирован';
      } else {
        errorMessage = e.message.toString();
      }

      emit(AuthFailureState(message: errorMessage));
    }
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    emit(AuthDisconnectState());
  }

  void setUser(User? user) {
    if (user != null) {
      emit(AuthSuccessState(user: user));
    } else {
      emit(AuthInitialState());
    }
  }
}
