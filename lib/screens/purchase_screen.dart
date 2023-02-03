import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/screens/signin_screen.dart';
import 'package:firebase_purchase/widgets/purchase_background.dart';
import 'package:firebase_purchase/widgets/purchase_box.dart';
import 'package:firebase_purchase/widgets/purchase_form.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  void initState() {
    final user = context.read<AuthCubit>().state.user;
    if (user != null) {
      context.read<PurchaseCubit>().loadPurchases(user.uid);
    } else {
      context.read<PurchaseCubit>().empty();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Покупки'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: IconButton(
              onPressed: () {
                context.read<AuthCubit>().signout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninScreen()),
                );
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      body: Stack(
        children: const [
          PurchaseBackground(),
          PurchaseBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PurchaseForm(id: '0'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
