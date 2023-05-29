import 'package:flutter/material.dart';
import 'package:my_test_app/screens/auth_screens/components/login_form.dart';
import 'package:my_test_app/utils/background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = "loginscreen";

  void _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully, show a success message or navigate to a different screen.
    } catch (error) {
      // Handle password reset email sending errors, show an error message or perform any additional operations.
      print('Password reset failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const LoginScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(
                  onForgotPassword: _resetPassword,
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
