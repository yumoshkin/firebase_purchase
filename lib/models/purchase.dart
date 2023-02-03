import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:firebase_purchase/models/timestamp_serializer.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
class Purchase with _$Purchase {
  const factory Purchase({
    required String id,
    required String userId,
    required String name,
    String? description,
    required bool isCompleted,
    @TimestampSerializer() required DateTime createdAt,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}
