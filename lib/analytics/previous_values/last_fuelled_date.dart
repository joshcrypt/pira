import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

import "../../models/petrol_expense_item.dart";

class LastFuelledDate extends StatefulWidget {
  const LastFuelledDate({super.key});

  @override
  State<LastFuelledDate> createState() => _LastFuelledDateState();
}

class _LastFuelledDateState extends State<LastFuelledDate> {
  @override
  Widget build(BuildContext context) {
    List<PetrolExpenseItem> petrolExpenseItems =
        Provider.of<List<PetrolExpenseItem>>(context);
    if (petrolExpenseItems.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                "Last Fuelled On",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(DateFormat.yMMMEd().format(item.createdAt)),
              Consumer(
                builder: (BuildContext context,
                    List<PetrolExpenseItem> petrolExpenseItems, Widget? child) {
                  return Text(
                    DateFormat.yMMMEd()
                            .format(petrolExpenseItems.last.createdAt)
                            .toString() ??
                        "",
                    style: const TextStyle(
                      color: Colors.deepPurple,
                    ),

                    // controller: _lastFuelledAtController,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
