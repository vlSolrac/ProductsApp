import 'package:flutter/material.dart';
import 'package:products/helpers/preferences.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/services/auth_service.dart';
import 'package:products/services/products_service.dart';
import 'package:products/theme/theme_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
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
      initialRoute: RoutesApp.splash,
      routes: RoutesApp.routes,
    );
  }
}
