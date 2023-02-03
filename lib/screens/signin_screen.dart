import 'package:flutter/material.dart';

import 'package:firebase_purchase/widgets/signin_form.dart';
import 'package:firebase_purchase/widgets/signin_header.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SigninHeader(),
              SigninForm(),
            ],
          ),
        ),
      ),
    );
  }
}
