import 'package:flutter_test/flutter_test.dart';

import 'package:adiantedoe/utils/phone_validator.dart';

void main() {
  group('validatePhoneDigits', () {
    test('aceita celular válido', () {
      expect(validatePhoneDigits('51999998888'), isNull);
      expect(validatePhoneDigits('11987654321'), isNull);
      expect(validatePhoneDigits('98991234567'), isNull);
    });

    test('rejeita vazio', () {
      expect(validatePhoneDigits(''), 'Informe o WhatsApp');
    });

    test('rejeita comprimento errado', () {
      // 10 dígitos (fixo, sem o 9)
      expect(validatePhoneDigits('5133334444'), contains('número completo'));
      // 12 dígitos
      expect(validatePhoneDigits('519999988881'), contains('número completo'));
    });

    test('rejeita número sem o 9 após o DDD', () {
      expect(validatePhoneDigits('51899998888'),
          'O celular deve começar com 9 após o DDD');
    });

    test('rejeita DDD inexistente', () {
      // 20, 23, 25, 26 e 30 não são DDDs em uso no Brasil
      for (final ddd in ['20', '23', '25', '26', '30']) {
        expect(validatePhoneDigits('${ddd}999998888'), 'DDD inválido',
            reason: 'DDD $ddd deveria ser inválido');
      }
    });

    test('aceita amostra de DDDs de todas as regiões', () {
      for (final ddd in ['11', '21', '31', '41', '51', '61', '71', '81', '91']) {
        expect(validatePhoneDigits('${ddd}999998888'), isNull,
            reason: 'DDD $ddd deveria ser válido');
      }
    });
  });
}
