import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/utils/functions.dart';
import 'package:firebase_purchase/widgets/form_field_email.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isAutovalidate = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void resetPassword(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isAutovalidate = true;
      });
      return;
    }

    context.read<AuthCubit>().resetPassword(_emailController.text.trim());
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
          title: const Text('Сброс пароля'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Введите свою почту',
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
                const SizedBox(height: 12),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () => resetPassword(context),
                    child: const Text(
                      'Сбросить пароль',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
