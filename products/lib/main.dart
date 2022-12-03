import 'package:flutter/material.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/theme/theme_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      theme: ThemeApp.lightTheme,
      initialRoute: RoutesApp.home,
      routes: RoutesApp.routes,
    );
  }
}
