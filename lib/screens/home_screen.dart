import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/screens/purchase_screen.dart';
import 'package:firebase_purchase/screens/signin_screen.dart';
import 'package:firebase_purchase/screens/verify_email_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        context.read<AuthCubit>().setUser(snapshot.data);

        if (snapshot.data == null) {
          return const SigninScreen();
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return const VerifyEmailScreen();
          }
          return const PurchaseScreen();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Ошибка аутентификации: ${snapshot.error}'),
            ),
          );
        } else {
          return const SigninScreen();
        }
      },
    );
  }
}
