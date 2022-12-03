import 'package:flutter/material.dart';
import 'package:products/screens/screens.dart';

class RoutesApp {
  static String home = "home";
  static String login = "login";

  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesApp.home: (p0) => const HomeScreen(),
    RoutesApp.login: (p0) => const LoginScreen(),
  };
}
