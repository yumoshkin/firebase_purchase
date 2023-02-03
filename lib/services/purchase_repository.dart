import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/services/purchase_api_provider.dart';

class PurchaseRepository {
  final PurchaseApiProvider _purchaseProvider = PurchaseApiProvider();

  Future<List<Purchase>> getPurchasesByUserId(String userId) =>
      _purchaseProvider.getByUserId(userId);

  Future<String> addPurchase(Purchase purchase) =>
      _purchaseProvider.add(purchase);

  Future<void> updatePurchase(Purchase purchase) =>
      _purchaseProvider.update(purchase);

  Future<void> deletePurchase(Purchase purchase) =>
      _purchaseProvider.delete(purchase);
}
