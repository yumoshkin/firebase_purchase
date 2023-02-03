import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/widgets/purchase_form.dart';

class PurchaseListItem extends StatelessWidget {
  const PurchaseListItem({Key? key, required this.purchase}) : super(key: key);
  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: purchase.isCompleted ? Colors.green[50] : Colors.grey[50],
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _purchaseItemData(context),
          _actionsRow(context),
        ],
      ),
    );
  }

  Widget _purchaseItemData(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(
          purchase.name,
          style: const TextStyle(
              color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          purchase.description ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          onTap: () => context.read<PurchaseCubit>().setCompleted(
                purchase.copyWith(
                  isCompleted: !purchase.isCompleted,
                ),
              ),
          child: Icon(
            purchase.isCompleted
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: purchase.isCompleted ? Colors.teal : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _actionsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PurchaseForm(id: purchase.id),
                ),
              );
            },
            child: const Icon(
              Icons.edit_outlined,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => _alertDialog(context),
                barrierDismissible: false,
              );
            },
            child: Icon(
              Icons.delete_outlined,
              color: Colors.amber[900],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _alertDialog(BuildContext context) {
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

  void delete(BuildContext context, [bool mounted = true]) async {
    await context.read<PurchaseCubit>().deletePurchase(purchase);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}
