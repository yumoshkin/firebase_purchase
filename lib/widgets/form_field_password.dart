import 'package:flutter/material.dart';

import 'package:firebase_purchase/utils/functions.dart';

class FormFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isAutovalidate;
  final bool isPasswordObscure;
  final Function() togglePasswordVisibility;
  const FormFieldPassword(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.isAutovalidate,
      required this.isPasswordObscure,
      required this.togglePasswordVisibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: TextFormField(
        controller: controller,
        autovalidateMode: isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        obscureText: isPasswordObscure,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
                isPasswordObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: togglePasswordVisibility,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        validator: validatePassword,
      ),
    );
  }
}
