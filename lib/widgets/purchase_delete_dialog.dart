import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/models/purchase.dart';

class PurchaseDeleteDialog extends StatelessWidget {
  final Purchase purchase;
  const PurchaseDeleteDialog({Key? key, required this.purchase})
      : super(key: key);

  void delete(BuildContext context, [bool mounted = true]) async {
    await context.read<PurchaseCubit>().deletePurchase(purchase);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Подтверждение'),
      content: Text(
        'Удалить запись "${purchase.name}"?',
        style: const TextStyle(fontSize: 18),
      ),
      actionsPadding: const EdgeInsets.only(bottom: 16, right: 16),
      actions: [
        TextButton(
          child: const Text(
            'Удалить',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => delete(context),
        ),
        TextButton(
          child: const Text(
            'Отменить',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
