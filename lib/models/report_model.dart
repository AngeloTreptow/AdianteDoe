import 'package:cloud_firestore/cloud_firestore.dart';

// Denúncia de um item publicado. A coleção `reports` é write-only para
// clientes (as regras permitem apenas create), por isso não há fromMap:
// as denúncias são lidas somente pelo console/admin.
class ReportModel {
  final String id;
  final String itemId;
  final String? reason;
  final DateTime createdAt;

  ReportModel({
    required this.id,
    required this.itemId,
    this.reason,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'itemId': itemId,
        'reason': reason,
        // Horário do servidor — as regras exigem createdAt == request.time
        'createdAt': FieldValue.serverTimestamp(),
      };
}
