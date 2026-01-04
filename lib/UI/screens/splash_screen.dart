import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/controller/auth_controller.dart';
import 'package:task_management/UI/utils/assets_path.dart';
import 'package:task_management/UI/widgets/screen_background.dart';
import 'package:task_management/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.loadUserData();
    print(authProvider.accessToken);
    // await AuthController.getUserData();

    if (authProvider.isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/navBar');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Image.asset(
            AssetsPath.logo,
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
