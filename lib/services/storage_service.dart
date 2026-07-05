import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  /// Lança exceção em caso de falha — quem chama decide como avisar o usuário.
  Future<String> uploadImage(File image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('items/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}