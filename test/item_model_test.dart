import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/item_model.dart';

void main() {
  group('ItemModel.toMap', () {
    test('inclui apenas os campos aceitos pelas regras do Firestore', () {
      final item = ItemModel(
        id: 'abc',
        name: 'Sofá 2 lugares',
        phone: '5551999998888',
        imageUrl: null,
        createdAt: DateTime(2026, 7, 5),
      );

      final map = item.toMap();

      expect(
        map.keys.toSet(),
        {'name', 'phone', 'imageUrl', 'createdAt', 'expiresAt'},
      );
      expect(map['name'], 'Sofá 2 lugares');
      expect(map['phone'], '5551999998888');
      expect(map['imageUrl'], isNull);
    });
  });

  group('ItemModel.fromMap', () {
    test('lê um documento completo', () {
      final createdAt = DateTime(2026, 7, 1, 10, 30);
      final item = ItemModel.fromMap('doc1', {
        'name': 'Cadeira',
        'phone': '5551999998888',
        'imageUrl': 'https://firebasestorage.googleapis.com/foto.jpg',
        'createdAt': Timestamp.fromDate(createdAt),
      });

      expect(item.id, 'doc1');
      expect(item.name, 'Cadeira');
      expect(item.phone, '5551999998888');
      expect(item.imageUrl, 'https://firebasestorage.googleapis.com/foto.jpg');
      expect(item.createdAt, createdAt);
    });

    test('não quebra com createdAt nulo (serverTimestamp pendente)', () {
      final item = ItemModel.fromMap('doc2', {
        'name': 'Mesa',
        'phone': '5551999998888',
      });

      expect(item.name, 'Mesa');
      expect(item.imageUrl, isNull);
      expect(item.createdAt, isA<DateTime>());
    });

    test('não quebra com campos ausentes', () {
      final item = ItemModel.fromMap('doc3', <String, dynamic>{});

      expect(item.name, '');
      expect(item.phone, '');
      expect(item.imageUrl, isNull);
    });
  });
}
