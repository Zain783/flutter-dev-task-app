import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_test_app/screens/auth_screens/login_screen.dart';
import 'package:my_test_app/screens/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _animation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0.3))
            .animate(_animationController);
    _animationController.forward();

    _checkLoggedInUser();
  }
  void _checkLoggedInUser() async {
    final user = FirebaseAuth.instance.currentUser;
    await Future.delayed(
        const Duration(seconds: 3)); // Simulating splash screen time

    if (user == null) {
      // User not logged in, navigate to auth screen
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, LoginScreen.route);
    } else {
      // User logged in, navigate to home screen
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, BottomNavigationbar.route);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SlideTransition(
            position: _animation,
            child: const Icon(
              Icons.ac_unit_outlined,
              color: Colors.deepPurple,
              size: 120,
            ),
          ),
        ),
      ),
    );
  }
}
