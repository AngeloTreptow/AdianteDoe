import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/feedback_model.dart';

void main() {
  group('FeedbackModel.toMap', () {
    test('inclui apenas os campos aceitos pelas regras do Firestore', () {
      final feedback = FeedbackModel(
        id: '',
        message: 'Poderia ter busca por categoria.',
        day: '2026-07-07',
        createdAt: DateTime(2026, 7, 7, 10, 30),
      );

      final map = feedback.toMap();

      expect(map.keys.toSet(), {'message', 'day', 'createdAt'});
      expect(map['message'], 'Poderia ter busca por categoria.');
      expect(map['day'], '2026-07-07');
    });
  });
}
