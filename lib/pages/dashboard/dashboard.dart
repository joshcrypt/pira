import "package:flutter/material.dart";
import 'package:pira/services/auth/auth_service.dart';

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
        title: const Text("Dashboard"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(),
          // Show current Price Per Litre
          // Add Price Per Litre for the month and show last changed
          // Create button
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
          ),
        ],
      ),
    );
  }
}
