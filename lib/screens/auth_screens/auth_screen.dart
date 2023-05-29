import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/background.dart';
import '../../widgets/login_signup_btn.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset('assets/auth_lottie.json'),
              const Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginAndSignupBtn(),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
