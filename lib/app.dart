import 'package:flutter/material.dart';
import 'package:task_management/UI/screens/login_page.dart';
import 'package:task_management/UI/screens/main_nav_bar_holder_screen.dart';
import 'package:task_management/UI/screens/sign_up_page.dart';
import 'package:task_management/UI/screens/splash_screen.dart';
import 'package:task_management/UI/screens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginPage(),
        '/signUp': (_) => SignUpPage(),
        '/navBar': (_) => MainNavBarHolderScreen(),
        '/updateProfile': (_) => UpdateProfileScreen(),
      },
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: const Size.fromWidth(double.maxFinite),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
    );
  }
}
