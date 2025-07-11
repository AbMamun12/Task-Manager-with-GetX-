import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/splash_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor ,
        textTheme: const TextTheme(),
        inputDecorationTheme: _InputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),

      home: SplashScreen(),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        fixedSize: Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  InputDecorationTheme _InputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w300,
        color: Colors.grey
      ),
      border: _InputBorder(),
      errorBorder: _InputBorder(),
      focusedBorder: _InputBorder(),
      enabledBorder: _InputBorder(),
    );
  }

  OutlineInputBorder _InputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
