import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/models/item_model.dart';
import 'package:adiantedoe/screens/add_item_screen.dart';
import 'package:adiantedoe/services/firebase_service.dart';

class _FakeFirebaseService extends FirebaseService {
  _FakeFirebaseService({this.shouldFail = false});

  final bool shouldFail;
  final added = <ItemModel>[];

  @override
  Future<void> addItem(ItemModel item) async {
    if (shouldFail) throw Exception('falha simulada');
    added.add(item);
  }
}

Future<void> _pumpScreen(WidgetTester tester, FirebaseService service) {
  return tester.pumpWidget(
    MaterialApp(home: AddItemScreen(firebaseService: service)),
  );
}

Future<void> _fillForm(WidgetTester tester,
    {String name = 'Sofá', String phone = '(51) 99999-8888'}) async {
  await tester.enterText(
      find.widgetWithText(TextFormField, 'Nome do item *'), name);
  await tester.enterText(
      find.widgetWithText(TextFormField, 'WhatsApp (com DDD) *'), phone);
}

void main() {
  testWidgets('submit vazio mostra erros de validação e não publica',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpScreen(tester, service);

    await tester.tap(find.text('Publicar doação'));
    await tester.pump();

    expect(find.text('Informe o nome do item'), findsOneWidget);
    expect(find.text('Informe o WhatsApp'), findsOneWidget);
    expect(service.added, isEmpty);
  });

  testWidgets('submit válido publica com telefone normalizado (DDI 55)',
      (tester) async {
    final service = _FakeFirebaseService();
    await _pumpScreen(tester, service);

    await _fillForm(tester);
    await tester.tap(find.text('Publicar doação'));
    await tester.pumpAndSettle();

    expect(service.added, hasLength(1));
    expect(service.added.single.name, 'Sofá');
    expect(service.added.single.phone, '5551999998888');
  });

  testWidgets('falha ao publicar mostra SnackBar e reabilita o botão',
      (tester) async {
    final service = _FakeFirebaseService(shouldFail: true);
    await _pumpScreen(tester, service);

    await _fillForm(tester);
    await tester.tap(find.text('Publicar doação'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Não foi possível publicar'),
      findsOneWidget,
    );
    // O botão volta a ficar habilitado para nova tentativa
    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });
}
