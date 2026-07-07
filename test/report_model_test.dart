import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/report_model.dart';

void main() {
  group('ReportModel.toMap', () {
    test('inclui apenas os campos aceitos pelas regras do Firestore', () {
      final report = ReportModel(
        id: 'r1',
        itemId: 'item123',
        reason: 'Telefone falso',
        createdAt: DateTime(2026, 7, 5),
      );

      final map = report.toMap();

      expect(map.keys.toSet(), {'itemId', 'reason', 'createdAt'});
      expect(map['itemId'], 'item123');
      expect(map['reason'], 'Telefone falso');
    });

    test('mantém reason nulo quando não informado', () {
      final report = ReportModel(
        id: 'r2',
        itemId: 'item456',
        createdAt: DateTime(2026, 7, 5),
      );

      final map = report.toMap();

      expect(map['itemId'], 'item456');
      expect(map['reason'], isNull);
    });
  });
}
