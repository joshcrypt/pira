import 'package:cloud_firestore/cloud_firestore.dart';

class PetrolExpenseItem {
  final double pricePerLitre;
  final double capacity;
  final double amount;
  final DateTime createdAt;
  final int mileage;
  final String? additionalInfo;
  final String? id;

  PetrolExpenseItem({
    this.id,
    required this.pricePerLitre,
    required this.capacity,
    required this.amount,
    required this.createdAt,
    required this.mileage,
    this.additionalInfo,
  });

  factory PetrolExpenseItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    Timestamp t = data?["createdAt"];
    DateTime fromFirestoreDT = t.toDate();
    return PetrolExpenseItem(
        id: snapshot.id,
        pricePerLitre: data?["pricePerLitre"],
        capacity: data?["capacity"],
        amount: data?["amount"],
        createdAt: fromFirestoreDT,
        mileage: data?["mileage"],
        additionalInfo: data?["additionalInfo"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "pricePerLitre": pricePerLitre,
      "capacity": capacity,
      "amount": amount,
      "createdAt": createdAt,
      "mileage": mileage,
      if (additionalInfo != null) "additionalInfo": additionalInfo,
    };
  }
}
