import 'package:flutter/material.dart';

import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/widgets/purchase_delete_dialog.dart';
import 'package:firebase_purchase/widgets/purchase_form.dart';

class PurchaseListItemActions extends StatelessWidget {
  final Purchase purchase;
  const PurchaseListItemActions({Key? key, required this.purchase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => PurchaseDeleteDialog(purchase: purchase),
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
}
