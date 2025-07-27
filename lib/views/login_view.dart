import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static String id = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'Login to your account',
        style: TextStyle(fontFamily: 'RationalDisplaySemiBold'),
      ),
    );
  }
}
