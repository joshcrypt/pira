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
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "LAST FUELLED ON",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              // Text(DateFormat.yMMMEd().format(item.createdAt)),
              Consumer(
                builder: (BuildContext context,
                    List<PetrolExpenseItem> petrolExpenseItems, Widget? child) {
                  petrolExpenseItems.sort((a, b) {
                    return a.createdAt.compareTo(b.createdAt);
                  });
                  return Text(
                    DateFormat.yMMMEd()
                            .format(petrolExpenseItems.last.createdAt)
                            .toString() ??
                        "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
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
