import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../models/petrol_expense_item.dart";

class LastFuelledDate extends StatelessWidget {
  const LastFuelledDate({super.key});

  @override
  Widget build(BuildContext context) {
    List<PetrolExpenseItem> petrolExpenseItems =
        Provider.of<List<PetrolExpenseItem>>(context);

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Text(
                "Last Fuelled On",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${petrolExpenseItems.last.createdAt}",
                style: TextStyle(color: Colors.deepPurple),
              )
            ],
          ),
        ],
      ),
    );
  }
}
