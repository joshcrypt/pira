import "package:flutter/material.dart";
import "package:pira/pages/dashboard/dashboard.dart";
import "package:pira/pages/view/view.dart";

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  final List _pages = [const DashboardPage(), const ViewPage()];

  void navigateToPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "View Consumption"),
        ],
        onTap: navigateToPage,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
