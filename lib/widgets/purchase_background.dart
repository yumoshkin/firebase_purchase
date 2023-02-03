import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PurchaseBackground extends StatelessWidget {
  const PurchaseBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instance;

    return Positioned.fill(
      child: FutureBuilder<String>(
        future: storage.ref('background_image.png').getDownloadURL(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? Image.network(snapshot.data!, fit: BoxFit.fill)
                : const SizedBox(),
      ),
    );
  }
}
