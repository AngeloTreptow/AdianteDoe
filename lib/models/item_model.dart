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

  factory ItemModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      id: doc.id,
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}