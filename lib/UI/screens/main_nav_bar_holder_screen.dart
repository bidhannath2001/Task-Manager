import 'package:flutter/material.dart';
import 'package:task_management/UI/screens/cancel_task_screen.dart';
import 'package:task_management/UI/screens/completed_task_screen.dart';
import 'package:task_management/UI/screens/new_task_screen.dart';
import 'package:task_management/UI/screens/progress_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 2.0,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.task), label: "New Task"),
          NavigationDestination(icon: Icon(Icons.refresh), label: "Progress"),
          NavigationDestination(icon: Icon(Icons.done_all), label: "Completed"),
          NavigationDestination(icon: Icon(Icons.close), label: "Cancelled"),
        ],
      ),
    );
  }
}
