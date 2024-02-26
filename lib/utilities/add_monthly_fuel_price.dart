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
    String formattedDate = DateFormat.yMMMd().format(currentDate);
    return Container(
        child: TextFormField(
      controller: _monthlyPetrolPriceController,
      decoration: InputDecoration(hintText: "$formattedDate Fuel Price"),
    ));
  }
}
