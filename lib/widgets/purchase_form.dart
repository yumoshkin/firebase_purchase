import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_purchase/cubits/auth/auth_cubit.dart';
import 'package:firebase_purchase/cubits/purchase/purchase_cubit.dart';
import 'package:firebase_purchase/models/purchase.dart';
import 'package:firebase_purchase/utils/functions.dart';
import 'package:firebase_purchase/widgets/form_field_text.dart';

class PurchaseForm extends StatefulWidget {
  const PurchaseForm({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends State<PurchaseForm> {
  final GlobalKey<FormState> _purchaseFormKey = GlobalKey<FormState>();

  late List<Purchase> _purchases;
  Purchase? _purchase;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  var _isValidSaveButton = false;

  @override
  void initState() {
    super.initState();
    _purchases = context.read<PurchaseCubit>().state.purchases;
    setFields();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void setFields() {
    if (widget.id != '0') {
      final index =
          _purchases.indexWhere((purchase) => purchase.id == widget.id);
      _purchase = _purchases[index];
      _nameController.text = _purchase!.name;
      if (_purchase!.description != null) {
        _descriptionController.text = _purchase!.description!;
      }
    }
  }

  void setValidSaveButton() {
    setState(() {
      if (_purchaseFormKey.currentState?.validate() ?? false) {
        _isValidSaveButton = true;
      } else {
        _isValidSaveButton = false;
      }
    });
  }

  void submit(BuildContext context) async {
    final user = context.read<AuthCubit>().state.user;
    if (user == null) {
      return;
    }

    if (widget.id == '0') {
      final purchase = Purchase(
        id: '',
        userId: user.uid,
        name: _nameController.text,
        description: _descriptionController.text,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await context.read<PurchaseCubit>().addPurchase(purchase);
    } else {
      final index = _purchases.indexWhere((item) => item.id == widget.id);
      await context.read<PurchaseCubit>().updatePurchase(
            _purchases[index].copyWith(
              name: _nameController.text,
              description: _descriptionController.text,
            ),
          );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchaseCubit, PurchaseState>(
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          showSnackBar(context, state.message, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.id == '0' ? 'Новая покупка' : 'Редактирование покупки',
          ),
        ),
        body: Form(
          key: _purchaseFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // _nameField(),
                  FormFieldText(
                    controller: _nameController,
                    labelText: 'Наименование',
                    autofocus: _purchase?.id == null,
                    isAutovalidate: true,
                    validator: (value) => validateRequiredField(
                        value, 'Наименование не должно быть пустым'),
                    onChanged: (_) => setValidSaveButton(),
                  ),
                  const SizedBox(height: 16.0),
                  FormFieldText(
                    controller: _descriptionController,
                    labelText: 'Описание',
                    autofocus: false,
                    isAutovalidate: false,
                    validator: (_) => null,
                    onChanged: (_) => setValidSaveButton(),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(140, 36),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed:
                              _isValidSaveButton ? () => submit(context) : null,
                          child: const Text('Сохранить'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(140, 36),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Отменить'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _nameField() {
  //   return TextFormField(
  //     controller: _nameController,
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     autofocus: _purchase?.id == null ? true : false,
  //     decoration: const InputDecoration(
  //       labelText: 'Наименование',
  //       border: OutlineInputBorder(),
  //     ),
  //     keyboardType: TextInputType.text,
  //     validator: (value) =>
  //         validateRequiredField(value, 'Наименование не должно быть пустым'),
  //     onChanged: (_) => setValidSaveButton(),
  //   );
  // }

  // Widget _descriptionField() {
  //   return TextFormField(
  //     controller: _descriptionController,
  //     autovalidateMode: AutovalidateMode.disabled,
  //     autofocus: _purchase?.id == null ? true : false,
  //     decoration: const InputDecoration(
  //       labelText: 'Описание',
  //       border: OutlineInputBorder(),
  //     ),
  //     keyboardType: TextInputType.text,
  //     onChanged: (_) => setValidSaveButton(),
  //   );
  // }
}
