import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_purchase/models/purchase.dart';

class PurchaseApiProvider {
  Future<List<Purchase>> getByUserId(String userId) async {
    List<Purchase> purchases = [];
    final collection =
        await FirebaseFirestore.instance.collection('purchases').get();

    for (var doc in collection.docs) {
      final purchase = Purchase.fromJson(doc.data());
      if (purchase.userId == userId) {
        purchases.add(purchase);
      }
    }

    return purchases;
  }

  Future<String> add(Purchase purchase) async {
    final doc = FirebaseFirestore.instance.collection('purchases').doc();
    final purchaseWithId = purchase.copyWith(id: doc.id);
    await doc.set(purchaseWithId.toJson());
    return doc.id;
  }

  Future<void> update(Purchase purchase) async {
    final doc =
        FirebaseFirestore.instance.collection('purchases').doc(purchase.id);
    final json = purchase.toJson();
    await doc.update(json);
  }

  Future<void> delete(Purchase purchase) async {
    final doc =
        FirebaseFirestore.instance.collection('purchases').doc(purchase.id);
    await doc.delete();
  }
}
