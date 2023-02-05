import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/models/purchase.dart';

class PurchaseListItemData extends StatelessWidget {
  final Purchase purchase;
  const PurchaseListItemData({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
