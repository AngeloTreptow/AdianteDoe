/// DDDs em uso no Brasil (Anatel).
const dddsValidos = [
  11, 12, 13, 14, 15, 16, 17, 18, 19,
  21, 22, 24, 27, 28,
  31, 32, 33, 34, 35, 37, 38,
  41, 42, 43, 44, 45, 46, 47, 48, 49,
  51, 53, 54, 55,
  61, 62, 63, 64, 65, 66, 67, 68, 69,
  71, 73, 74, 75, 77, 79,
  81, 82, 83, 84, 85, 86, 87, 88, 89,
  91, 92, 93, 94, 95, 96, 97, 98, 99,
];

/// Valida um celular brasileiro a partir dos dígitos sem máscara (DDD + número).
/// Retorna a mensagem de erro, ou null se o número for válido.
String? validatePhoneDigits(String digits) {
  if (digits.isEmpty) return 'Informe o WhatsApp';

  if (digits.length != 11) {
    return 'Informe o número completo com o 9. Ex: (51) 98888-7777';
  }

  if (digits[2] != '9') {
    return 'O celular deve começar com 9 após o DDD';
  }

  final ddd = int.tryParse(digits.substring(0, 2));
  if (ddd == null || !dddsValidos.contains(ddd)) {
    return 'DDD inválido';
  }

  return null;
}
