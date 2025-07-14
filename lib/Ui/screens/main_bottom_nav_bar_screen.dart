/*
import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/cancelled_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/completed_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/new_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/progress_task_screen.dart';
import 'package:task_manager/Ui/widgets/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(

        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.new_label,), label: 'New'),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancelled'),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: 'progress',
          ),
        ],
      ),
    );
  }
}

*/
import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/cancelled_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/completed_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/new_task_screen.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/progress_task_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';
import 'package:task_manager/Ui/widgets/tm_app_bar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  final _items = const [
    (_NewNavItem(icon: Icons.new_label, label: 'New')),
    (_NewNavItem(icon: Icons.check_box, label: 'Completed')),
    (_NewNavItem(icon: Icons.cancel, label: 'Cancelled')),
    (_NewNavItem(icon: Icons.access_time_outlined, label: 'Progress')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildCustomNavBar(),
    );
  }

  Widget _buildCustomNavBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: List.generate(_items.length, (index) {
          final bool selected = _selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                color: selected ? AppColors.themeColor : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _items[index].icon,
                      size: 22,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _items[index].label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NewNavItem {
  final IconData icon;
  final String label;
  const _NewNavItem({required this.icon, required this.label});
}

