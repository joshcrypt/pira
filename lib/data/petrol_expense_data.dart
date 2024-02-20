import '../models/petrol_expense_item.dart';

class PetrolExpenseData {
//  List of Petrol Expenses
  List<PetrolExpenseItem> petrolExpenseItems = [];

//  Get List of all Petrol Items
  List? getPetrolItems() {
    if (checkPetrolList()) {
      return null;
    }
    return petrolExpenseItems;
  }

// Get Individual Expense by Id
  PetrolExpenseItem? getPetrolExpenseItem(int i) {
    if (checkPetrolList()) {
      return null;
    }
    return petrolExpenseItems[i];
  }

//  Check if petrol List is empty
  bool checkPetrolList() {
    if (petrolExpenseItems.isEmpty) {
      return false;
    }
    return true;
  }

//  Add Petrol Expense
  void addPetrolExpenseItem(PetrolExpenseItem petrolExpenseItem) {
    petrolExpenseItems.add(petrolExpenseItem);
  }

//  Delete Petrol Expense
  void deletePetrolExpense(PetrolExpenseItem petrolExpenseItem) {
    petrolExpenseItems.remove(petrolExpenseItem);
  }

//  Update Petrol Expense
  void updatePetrolExpense(int id) {
    petrolExpenseItems.where((element) => false);
  }
}
