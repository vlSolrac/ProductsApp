import 'package:flutter/material.dart';
import 'package:products/screens/screens.dart';

class RoutesApp {
  static String home = "home";

  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesApp.home: (p0) => const HomeScreen(),
  };
}
