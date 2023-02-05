import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SigninHeader extends StatefulWidget {
  const SigninHeader({Key? key}) : super(key: key);

  @override
  State<SigninHeader> createState() => _SigninHeaderState();
}

class _SigninHeaderState extends State<SigninHeader> {
  final storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xffe8f6e9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 130,
                  padding: const EdgeInsets.only(left: 24),
                  child: const Text(
                    'Покупки',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff827717),
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              Container(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(16),
                child: Image.asset('assets/images/cart.png'),
              ),
            ],
          ),
        ),
        Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Text(
                'Добро пожаловать',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Введите свою почту и пароль, чтобы войти',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            )
          ],
        ),
      ],
    );
  }
}
