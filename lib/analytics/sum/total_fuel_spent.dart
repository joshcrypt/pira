import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:pira/models/petrol_expense_item.dart";
import "package:provider/provider.dart";

class TotalFuelSpent extends StatelessWidget {
  const TotalFuelSpent({super.key});

  @override
  Widget build(BuildContext context) {
    List<PetrolExpenseItem> petrolExpenseItems =
        Provider.of<List<PetrolExpenseItem>>(context);
    double totalAmountSpent = 0;

    if (petrolExpenseItems.isEmpty) {
      return CircularProgressIndicator();
    } else {
      for (var item in petrolExpenseItems) {
        totalAmountSpent += item.amount;
      }
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Total Amount Spent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  formatCurrency(totalAmountSpent),
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  static String formatCurrency(
    double value, {
    String locale = 'en_KE',
    String symbol = 'KES',
    int decimalDigits = 2,
  }) {
    final numberFormat = NumberFormat.currency(
      locale: locale,
      symbol: '$symbol ',
      decimalDigits: decimalDigits,
    );
    return numberFormat.format(value);
  }
}
