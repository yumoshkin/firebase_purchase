import 'package:flutter/material.dart';

class FormFieldText extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool autofocus;
  final bool isAutovalidate;
  final String? Function(String? value)? validator;
  final Function(String? value)? onChanged;
  const FormFieldText({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.autofocus,
    required this.isAutovalidate,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        autovalidateMode: isAutovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
