import 'package:cloud_firestore/cloud_firestore.dart';

// Sugestão/feedback enviado pela comunidade. Como `reports`, a coleção
// `feedback` é write-only para clientes (as regras permitem apenas create),
// por isso não há fromMap: as sugestões são lidas somente pelo console/admin.
class FeedbackModel {
  final String id;
  final String message;
  // Dia local (AAAA-MM-DD) usado no ID determinístico {uid}_{dia}, que
  // limita a uma sugestão por dispositivo por dia
  final String day;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.message,
    required this.day,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'message': message,
        'day': day,
        // Horário do servidor — as regras exigem createdAt == request.time
        'createdAt': FieldValue.serverTimestamp(),
      };
}
