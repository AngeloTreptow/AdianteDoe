import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class FirebaseService {
  final _col = FirebaseFirestore.instance.collection('items');

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

  // Método mantido mas NÃO deve ser chamado pelo app.
  // A exclusão agora é feita pelo TTL do Firestore Console + Cloud Function.
  Future<void> deleteOldItems() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 14));
    final old = await _col
        .where('createdAt', isLessThan: Timestamp.fromDate(cutoff))
        .get();
    for (final doc in old.docs) {
      await doc.reference.delete();
    }
  }
}
