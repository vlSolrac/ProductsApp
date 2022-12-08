import 'package:flutter/material.dart';
import 'package:products/screens/home_screen.dart';
import 'package:products/screens/login_screen.dart';
import 'package:products/screens/product_screen.dart';
import 'package:products/screens/register_screen.dart';
import 'package:products/screens/splash_screen.dart';

class RoutesApp {
  static String home = "home";
  static String login = "login";
  static String product = "product";
  static String register = "register";
  static String splash = "splash";

  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesApp.home: (p0) => const HomeScreen(),
    RoutesApp.login: (p0) => const LoginScreen(),
    RoutesApp.product: (p0) => const ProductScreen(),
    RoutesApp.register: (p0) => const RegisterScreen(),
    RoutesApp.register: (p0) => const RegisterScreen(),
    RoutesApp.splash: (p0) => const SplashScreen(),
  };
}
