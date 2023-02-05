import 'package:flutter/material.dart';

import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/widgets/purchase_list_item_data.dart';
import 'package:firebase_purchase/widgets/purchase_list_item_actions.dart';

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
          PurchaseListItemData(purchase: purchase),
          PurchaseListItemActions(purchase: purchase),
        ],
      ),
    );
  }
}
