import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/Ui/screens/splash_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';
import 'package:task_manager/controller_binder.dart';

class TaskManagerApp extends StatefulWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState>navigatorKey=GlobalKey<NavigatorState>();


  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor ,
        textTheme: const TextTheme(),
        inputDecorationTheme: _InputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),


      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes:{
        SplashScreen.name:(context)=> SplashScreen(),
        MainBottomNavBarScreen.name:(context) => const MainBottomNavBarScreen()
      } ,
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
