import "package:flutter/material.dart";
import "package:pira/analytics/sum/total_fuel_spent.dart";
import 'package:pira/services/auth/auth_service.dart';

import "../../analytics/previous_values/last_fuelled_date.dart";
import "../../utilities/common_form.dart";

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String formName = "Add Expense";

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Service Initialization
  final AuthService _authService = AuthService();

  void logout() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pira"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // MonthlyFuelPrice(),
          // Show current Price Per Litre
          // Show previous readings
          // Add Price Per Litre for the month and show last changed
          const Row(
            children: [
              TotalFuelSpent(),
              LastFuelledDate(),
            ],
          ),

          // Create button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text("Add Expense"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: CommonForm(
                                    buttonTitle: DashboardPage.formName),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
