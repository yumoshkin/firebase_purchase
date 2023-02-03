import 'package:flutter/material.dart';

import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/widgets/purchase_list_item.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({super.key, required this.purchases});
  final List<Purchase> purchases;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: purchases.length,
      itemBuilder: (context, index) =>
          PurchaseListItem(purchase: purchases[index]),
    );
  }
}
