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
        {'name', 'phone', 'description', 'imageUrl', 'createdAt', 'expiresAt'},
      );
      expect(map['name'], 'Sofá 2 lugares');
      expect(map['phone'], '5551999998888');
      expect(map['imageUrl'], isNull);
    });
  });
}
