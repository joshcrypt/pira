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
          height: 100,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "CUMULATIVE AMOUNT",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                Flexible(
                  child: Text(
                    formatCurrency(totalAmountSpent) ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
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
