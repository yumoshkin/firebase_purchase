import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final Exception? error;
  const ErrorText({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ошибка'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
