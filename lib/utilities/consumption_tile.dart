import "package:flutter/material.dart";
import "package:pira/models/petrol_expense_item.dart";

class ConsumptionTile extends StatelessWidget {
  final PetrolExpenseItem petrolExpenseItem;

  const ConsumptionTile({
    super.key,
    required this.petrolExpenseItem,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //   Date
        Text(petrolExpenseItem.createdAt.toString()),
        const SizedBox(
          width: 2,
        ),
        Text(petrolExpenseItem.mileage.toString()),
        const SizedBox(
          width: 2,
        ),
        Text(petrolExpenseItem.capacity.toString()),
        const SizedBox(
          width: 2,
        ),
        Text(petrolExpenseItem.pricePerLitre.toString()),
        const SizedBox(
          width: 2,
        ),
        Text(petrolExpenseItem.amount.toString()),
        const SizedBox(
          width: 2,
        ),
        Text(petrolExpenseItem.additionalInfo.toString()),
        //   Mileage
        //   Consumption
        //   PPL
        //   Amount
      ],
    );
  }
}
