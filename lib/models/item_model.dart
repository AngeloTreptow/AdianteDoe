import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  final String name;
  final String phone;
  final String? imageUrl;
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.name,
    required this.phone,
    this.imageUrl,
    required this.createdAt,
  });

  factory ItemModel.fromDoc(DocumentSnapshot doc) =>
      ItemModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);

  factory ItemModel.fromMap(String id, Map<String, dynamic> data) {
    return ItemModel(
      id: id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'],
      // Pode ser null no snapshot local enquanto o serverTimestamp está pendente
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'imageUrl': imageUrl,
        // Horário do servidor — as regras exigem createdAt == request.time
        'createdAt': FieldValue.serverTimestamp(),
        // Data de expiração usada pela política de TTL do Firestore.
        // Usa o relógio do cliente; as regras validam com tolerância de ±1 dia.
        'expiresAt': Timestamp.fromDate(
          DateTime.now().add(const Duration(days: 14)),
        ),
      };
}