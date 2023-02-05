import 'package:flutter/material.dart';

import 'package:firebase_purchase/utils/functions.dart';

class FormFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isAutovalidate;
  const FormFieldEmail({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.isAutovalidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: TextFormField(
        controller: controller,
        autovalidateMode: isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.mail),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
      ),
    );
  }
}
