import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pira/models/petrol_expense_item.dart';
import 'package:pira/services/auth/auth_service.dart';

class PiraService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  late void Function() onPressed;

//   get stream of fuel details
  Stream<List<PetrolExpenseItem>> getConsumptionData() {
    final snapShot = _firestore
        .collection("consumption")
        .withConverter(
          fromFirestore: PetrolExpenseItem.fromFirestore,
          toFirestore: (PetrolExpenseItem petrolExpenseItem, _) =>
              petrolExpenseItem.toFirestore(),
        )
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        final pira = documentSnapshot.data();
        return pira;
      }).toList();
    });
    return snapShot;
  }

  Stream<List<PetrolExpenseItem>> fetchUserConsumptionDocument() {
    final currentUser = _authService.getCurrentUser();
    final snapShot = _firestore
        .collection("user_petrol_consumption")
        .doc(currentUser?.uid)
        .collection("fuel_data")
        .withConverter(
          fromFirestore: PetrolExpenseItem.fromFirestore,
          toFirestore: (PetrolExpenseItem petrolExpenseItem, _) =>
              petrolExpenseItem.toFirestore(),
        )
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        final pira = documentSnapshot.data();
        return pira;
      }).toList();
    });
    return snapShot;
  }

  Future<(bool, String)> createUserConsumptionDocument(
      PetrolExpenseItem petrolExpenseItem, BuildContext context) async {
    final currentUser = _authService.getCurrentUser();
    try {
      await _firestore
          .collection("user_petrol_consumption")
          .doc(currentUser?.uid)
          .collection("fuel_data")
          .withConverter(
            fromFirestore: PetrolExpenseItem.fromFirestore,
            toFirestore: (PetrolExpenseItem petrolExpenseItem, options) =>
                petrolExpenseItem.toFirestore(),
          )
          .add(petrolExpenseItem)
          .then((documentSnapshot) {});
      return (true, 'Created Successfully');
    } catch (e) {
      return (false, "Failed to add document");
    }
  }

  Future<(bool, String)> updateUserConsumptionDocument(
      PetrolExpenseItem petrolExpenseItem, BuildContext context) async {
    final currentUser = _authService.getCurrentUser();
    try {
      await _firestore
          .collection("user_petrol_consumption")
          .doc(currentUser?.uid)
          .collection("fuel_data")
          .doc(petrolExpenseItem.id)
          .withConverter(
            fromFirestore: PetrolExpenseItem.fromFirestore,
            toFirestore: (PetrolExpenseItem petrolExpenseItem, options) =>
                petrolExpenseItem.toFirestore(),
          )
          .update(petrolExpenseItem.toFirestore())
          .then((documentSnapshot) {});
      return (true, 'Update Successfully');
    } catch (e) {
      return (false, 'Failed to Update');
    }
  }

  Future<(bool, String)> removeUserConsumptionDocument(
      PetrolExpenseItem petrolExpenseItem, BuildContext context) async {
    final currentUser = _authService.getCurrentUser();
    try {
      await _firestore
          .collection("user_petrol_consumption")
          .doc(currentUser?.uid)
          .collection("fuel_data")
          .doc(petrolExpenseItem.id)
          .withConverter(
            fromFirestore: PetrolExpenseItem.fromFirestore,
            toFirestore: (PetrolExpenseItem petrolExpenseItem, options) =>
                petrolExpenseItem.toFirestore(),
          )
          .delete()
          .then((documentSnapshot) {});
      return (true, "Deleted Successfully");
    } catch (e) {
      return (false, "Failed to Delete");
    }
  }
}
