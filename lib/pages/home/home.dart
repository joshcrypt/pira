import "package:flutter/material.dart";
import "package:pira/pages/create/create.dart";
import "package:pira/pages/view/view.dart";

import "../dashboard/dashboard.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final List _pages = [const CreatePage(), const DashboardPage(), const ViewPage()];

  void _navigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: _pages[_selectedIndex],
      // Text(_pages[_selectedIndex].toString()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigationBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Create"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "View"),
        ],
      ),
    );
  }
}
