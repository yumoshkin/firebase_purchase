import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/screens/home_screen.dart';
import 'package:firebase_purchase/screens/reset_password_screen.dart';
import 'package:firebase_purchase/screens/signup_screen.dart';
import 'package:firebase_purchase/utils/functions.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isAutovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
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
              _emailField(),
              _passwordField(),
              _resetPasswordButton(),
              _signinButton(),
              _signupButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 82,
      child: TextFormField(
        controller: _emailController,
        autovalidateMode: _isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: const InputDecoration(
          labelText: 'Адрес электронной почты *',
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.mail,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        controller: _passwordController,
        autovalidateMode: _isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Пароль *',
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(
            Icons.lock,
          ),
          suffixIcon: IconButton(
            icon: Icon(
                !_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: togglePasswordVisibility,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: validatePassword,
      ),
    );
  }

  Widget _resetPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
          ),
        ),
        child: const Text(
          'Забыли пароль?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _signinButton() {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () => signin(context),
        child: const Text(
          'Войти',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _signupButton() {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        ),
      ),
      child: const Text(
        'Нет регистрации? Зарегистрируйтесь',
        style: TextStyle(
          fontSize: 16,
          color: Colors.teal,
        ),
      ),
    );
  }
}
