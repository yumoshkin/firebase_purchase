part of 'purchase_cubit.dart';

abstract class PurchaseState {
  List<Purchase> get purchases;
  set purchases(List<Purchase> purchases);
  String get message;
  set message(String message);
}

class PurchaseLoadingState extends PurchaseState {
  @override
  List<Purchase> purchases = <Purchase>[];
  @override
  String message = '';
}

class PurchaseLoadedState extends PurchaseState {
  @override
  List<Purchase> purchases = <Purchase>[];
  @override
  String message = '';
  PurchaseLoadedState({required this.purchases});
}

class PurchaseEmptyState extends PurchaseState {
  @override
  List<Purchase> purchases = <Purchase>[];
  @override
  String message = '';
}

class PurchaseErrorState extends PurchaseState {
  @override
  List<Purchase> purchases = <Purchase>[];
  @override
  String message = '';
  PurchaseErrorState({required this.message});
}
