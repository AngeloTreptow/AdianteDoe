import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class FirebaseService {
  // Getter lazy: permite criar fakes desta classe em testes sem inicializar o Firebase
  CollectionReference<Map<String, dynamic>> get _col =>
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem(ItemModel item) async {
    await _col.add(item.toMap());
  }

  Stream<List<ItemModel>> getItems() {
    final cutoff = DateTime.now().subtract(const Duration(days: 14));
    return _col
        .where('createdAt', isGreaterThan: Timestamp.fromDate(cutoff))
        .orderBy('createdAt', descending: true)
        .limit(25) // Limita a 25 itens para economizar leituras
        .snapshots()
        .map((snap) => snap.docs.map(ItemModel.fromDoc).toList());
  }

}
