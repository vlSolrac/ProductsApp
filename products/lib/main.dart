import 'package:flutter/material.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/services/products_service.dart';
import 'package:products/theme/theme_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductsService())],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      theme: ThemeApp.lightTheme,
      initialRoute: RoutesApp.login,
      routes: RoutesApp.routes,
    );
  }
}
