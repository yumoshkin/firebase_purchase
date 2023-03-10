import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/screens/home_screen.dart';
import 'package:firebase_purchase/screens/reset_password_screen.dart';
import 'package:firebase_purchase/screens/signup_screen.dart';
import 'package:firebase_purchase/utils/functions.dart';
import 'package:firebase_purchase/widgets/form_field_email.dart';
import 'package:firebase_purchase/widgets/form_field_password.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isAutovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  void signin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isAutovalidate = true;
      });
      return;
    }

    final isLogged = await context.read<AuthCubit>().signin(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

    if (isLogged && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          showSnackBar(context, state.message, true);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              FormFieldEmail(
                controller: _emailController,
                labelText: '?????????? ?????????????????????? ?????????? *',
                isAutovalidate: _isAutovalidate,
              ),
              const SizedBox(height: 16),
              FormFieldPassword(
                controller: _passwordController,
                labelText: '???????????? *',
                isAutovalidate: _isAutovalidate,
                isPasswordObscure: _isPasswordObscure,
                togglePasswordVisibility: togglePasswordVisibility,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  ),
                  child: const Text(
                    '???????????? ?????????????',
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () => signin(context),
                  child: const Text(
                    '??????????',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                ),
                child: const Text(
                  '?????? ??????????????????????? ??????????????????????????????????',
                  style: TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
