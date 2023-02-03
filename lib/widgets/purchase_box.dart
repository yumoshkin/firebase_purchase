import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/widgets/purchase_list.dart';

class PurchaseBox extends StatelessWidget {
  const PurchaseBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );

    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        if (state is PurchaseLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PurchaseLoadedState) {
          return PurchaseList(purchases: state.purchases);
        }

        if (state is PurchaseEmptyState) {
          return const Center(
            child: Text(
              'Нет данных о покупках',
              style: textStyle,
            ),
          );
        }

        if (state is PurchaseErrorState) {
          return Center(
            child: Text(
              'Ошибка при получении покупок: ${context.read<PurchaseCubit>().state.message}',
              style: textStyle,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
