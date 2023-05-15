import 'package:flutter/material.dart';
import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(primarySwatch: Colors.green),
    initialRoute: "/login",
    routes: {
      "/login": (context) => LoginPage(),
      "/home": (context) => HomePage(),
    },
  );
  }
}