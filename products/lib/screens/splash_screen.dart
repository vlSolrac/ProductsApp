import 'package:flutter/material.dart';
import 'package:products/routes/routes_app.dart';
import 'package:products/screens/home_screen.dart';
import 'package:products/screens/login_screen.dart';
import 'package:products/services/auth_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
//Parametes.

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.
    // final size = MediaQuery.of(context).size;
    // final statusBar = MediaQuery.of(context).viewPadding;

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.getToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text("Espere");

            if (snapshot.data == "") {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginScreen(),
                        transitionDuration: const Duration(seconds: 0)));
                // Navigator.popAndPushNamed(context, RoutesApp.home);
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomeScreen(),
                        transitionDuration: const Duration(seconds: 0)));
                // Navigator.popAndPushNamed(context, RoutesApp.home);
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
