/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/progress_task_list_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import 'canceled_task_list_screen.dart';
import 'completed_task_list_screen.dart';
import 'new_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  RxInt _selectedIndex = 0.obs;

  final List<Widget> _screens = const [
    NewTaskListScreen(),
    CompletedTaskListScreen(),
    CanceledTaskListScreen(),
    ProgressTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[_selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex.value,
          selectedItemColor: AppColors.themColor,
          onTap: (index) {
            _selectedIndex.value = index;
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.new_label), label: 'New Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sticky_note_2), label: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel), label: 'Canceled'),
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle), label: 'Progress'),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/screens/progress_task_list_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import 'canceled_task_list_screen.dart';
import 'completed_task_list_screen.dart';
import 'new_task_list_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  RxInt _selectedIndex = 0.obs;

  final List<Widget> _screens = const [
    NewTaskListScreen(),
    CompletedTaskListScreen(),
    CanceledTaskListScreen(),
    ProgressTaskListScreen(),
  ];

  final List<_NewNavItem> _items = const [
    _NewNavItem(icon: Icons.new_label, label: 'New'),
    _NewNavItem(icon: Icons.check_box, label: 'Completed'),
    _NewNavItem(icon: Icons.cancel, label: 'Canceled'),
    _NewNavItem(icon: Icons.access_time_outlined, label: 'Progress'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[_selectedIndex.value]),
      bottomNavigationBar: Obx(() => _buildCustomNavBar()),
    );
  }

  Widget _buildCustomNavBar() {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black12),
          ),
        ),
        child: Row(
          children: List.generate(_items.length, (index) {
            final bool selected = _selectedIndex.value == index;
      
            return Expanded(
              child: InkWell(
                onTap: () => _selectedIndex.value = index,
                child: Container(
                  color: selected ? AppColors.themColor : Colors.white,
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
      ),
    );
  }
}

class _NewNavItem {
  final IconData icon;
  final String label;
  const _NewNavItem({required this.icon, required this.label});
}
