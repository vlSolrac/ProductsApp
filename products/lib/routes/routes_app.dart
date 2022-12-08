import 'package:flutter/material.dart';
import 'package:products/screens/home_screen.dart';
import 'package:products/screens/login_screen.dart';
import 'package:products/screens/product_screen.dart';
import 'package:products/screens/register_screen.dart';

class RoutesApp {
  static String home = "home";
  static String login = "login";
  static String product = "product";
  static String register = "register";

  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesApp.home: (p0) => HomeScreen(),
    RoutesApp.login: (p0) => const LoginScreen(),
    RoutesApp.product: (p0) => ProductScreen(),
    RoutesApp.register: (p0) => const RegisterScreen(),
  };
}
