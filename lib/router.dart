import 'package:flutter/material.dart';
import 'package:my_test_app/screens/auth_screens/login_screen.dart';
import 'package:my_test_app/screens/auth_screens/signup_screen.dart';
import 'package:my_test_app/screens/bottom_navbar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case SignUpScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignUpScreen(),
      );
    case BottomNavigationbar.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavigationbar(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
