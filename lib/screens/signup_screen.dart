import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/screens/home_screen.dart';
import 'package:firebase_purchase/utils/functions.dart';
import 'package:firebase_purchase/widgets/form_field_email.dart';
import 'package:firebase_purchase/widgets/form_field_password.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _isPasswordObscure = true;
  bool _isAutovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordObscure = !_isPasswordObscure;
    });
  }

  void signup(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isAutovalidate = true;
      });
      return;
    }

    await context.read<AuthCubit>().signup(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _passwordConfirmationController.text.trim(),
        );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Заполните поля для регистрации',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
                  FormFieldEmail(
                    controller: _emailController,
                    labelText: 'Адрес электронной почты *',
                    isAutovalidate: _isAutovalidate,
                  ),
                  const SizedBox(height: 16),
                  FormFieldPassword(
                    controller: _passwordController,
                    labelText: 'Пароль *',
                    isAutovalidate: _isAutovalidate,
                    isPasswordObscure: _isPasswordObscure,
                    togglePasswordVisibility: togglePasswordVisibility,
                  ),
                  const SizedBox(height: 16),
                  FormFieldPassword(
                    controller: _passwordConfirmationController,
                    labelText: 'Подтверждение пароля *',
                    isAutovalidate: _isAutovalidate,
                    isPasswordObscure: _isPasswordObscure,
                    togglePasswordVisibility: togglePasswordVisibility,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => signup(context),
                      child: const Text(
                        'Зарегистрировать',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
