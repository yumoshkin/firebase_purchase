import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/services/purchase_repository.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final PurchaseRepository purchaseRepository;
  PurchaseCubit({required this.purchaseRepository})
      : super(PurchaseEmptyState());

  Future<void> loadPurchases(String userId) async {
    try {
      emit(PurchaseLoadingState());

      final List<Purchase> purchases =
          await purchaseRepository.getPurchasesByUserId(userId);

      if (purchases.isNotEmpty) {
        sortPurchases(purchases);
        emit(PurchaseLoadedState(purchases: purchases));
      } else {
        emit(PurchaseEmptyState());
      }
    } catch (e) {
      emit(PurchaseErrorState(message: e.toString()));
    }
  }

  Future<void> addPurchase(Purchase purchase) async {
    try {
      final id = await purchaseRepository.addPurchase(purchase);

      List<Purchase> purchases = List.from(state.purchases)
        ..add(purchase.copyWith(id: id));
      sortPurchases(purchases);

      emit(PurchaseLoadedState(purchases: purchases));
    } catch (e) {
      emit(PurchaseErrorState(message: e.toString()));
    }
  }

  Future<void> updatePurchase(Purchase purchase) async {
    try {
      await purchaseRepository.updatePurchase(purchase);

      List<Purchase> purchases = List.from(state.purchases);
      final index =
          purchases.indexWhere((element) => element.id == purchase.id);
      purchases[index] = purchase;
      sortPurchases(purchases);

      emit(PurchaseLoadedState(purchases: purchases));
    } catch (e) {
      emit(PurchaseErrorState(message: e.toString()));
    }
  }

  Future<void> deletePurchase(Purchase purchase) async {
    try {
      await purchaseRepository.deletePurchase(purchase);

      List<Purchase> purchases = state.purchases.where((item) {
        return item.id != purchase.id;
      }).toList();

      if (purchases.isNotEmpty) {
        emit(PurchaseLoadedState(purchases: purchases));
      } else {
        emit(PurchaseEmptyState());
      }
    } catch (e) {
      emit(PurchaseErrorState(message: e.toString()));
    }
  }

  Future<void> setCompleted(Purchase purchase) async {
    try {
      await purchaseRepository.updatePurchase(purchase);

      List<Purchase> purchases = List.from(state.purchases);
      final index =
          purchases.indexWhere((element) => element.id == purchase.id);
      purchases[index] = purchase;
      sortPurchases(purchases);

      emit(PurchaseLoadedState(purchases: purchases));
    } catch (e) {
      emit(PurchaseErrorState(message: e.toString()));
    }
  }

  void sortPurchases(List<Purchase> purchases) {
    if (purchases.isNotEmpty) {
      purchases.sort((a, b) {
        int isCompletedComp =
            a.isCompleted.toString().compareTo(b.isCompleted.toString());
        if (isCompletedComp == 0) {
          return a.createdAt.compareTo(b.createdAt);
        }
        return isCompletedComp;
      });
    }
  }

  void empty() {
    emit(PurchaseEmptyState());
  }
}
