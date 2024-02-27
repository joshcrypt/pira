import "package:flutter/material.dart";
import "package:intl/intl.dart";

class MonthlyFuelPrice extends StatefulWidget {
  const MonthlyFuelPrice({super.key});

  @override
  State<MonthlyFuelPrice> createState() => _MonthlyFuelPriceState();
}

class _MonthlyFuelPriceState extends State<MonthlyFuelPrice> {
  final _monthlyPetrolPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    String formattedMonth = DateFormat("MMMM").format(currentDate);
    String formattedYear = DateFormat("yyyy").format(currentDate);
    return Column(
      children: [
        Text("Enter $formattedMonth $formattedYear Fuel Price/Litre"),
        TextFormField(
          controller: _monthlyPetrolPriceController,
          decoration: InputDecoration(
            hintText: "",
          ),
        ),
      ],
    );
  }
}
