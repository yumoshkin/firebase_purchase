import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/screens/home_screen.dart';
import 'package:firebase_purchase/utils/functions.dart';

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
  bool _isAutovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
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
                  const SizedBox(height: 8),
                  const Text(
                    'Заполните поля для регистрации',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  _emailField(),
                  _passwordField(),
                  _passwordConfirmationField(),
                  const SizedBox(height: 8),
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

  Widget _emailField() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      height: 82,
      child: TextFormField(
        controller: _emailController,
        autovalidateMode: _isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: const InputDecoration(
          labelText: 'Адрес электронной почты *',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 82,
      child: TextFormField(
        controller: _passwordController,
        autovalidateMode: _isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Пароль *',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: validatePassword,
      ),
    );
  }

  Widget _passwordConfirmationField() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 82,
      child: TextFormField(
        controller: _passwordConfirmationController,
        autovalidateMode: _isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Подтверждение пароля *',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: validatePassword,
      ),
    );
  }
}
