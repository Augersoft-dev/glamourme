import 'package:flutter/material.dart';
import 'package:glamourme/view/auth/login/login.dart';
import 'package:glamourme/view/navigation/bavigation_bar.dart';
import 'package:glamourme/view/onboarding/onboarding.dart';
import 'package:glamourme/view/theme/theme.dart';

import 'view/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glamourme',
      theme: customTheme(),
      home: LoginPage(),
    );
  }
}
