import 'package:flutter/material.dart';
import 'package:products/theme/theme_app.dart';

class LoadingScreen extends StatelessWidget {
//Parametes.

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.
    // final size = MediaQuery.of(context).size;
    // final statusBar = MediaQuery.of(context).viewPadding;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
        ),
        body: Center(
          child: CircularProgressIndicator(
            color: ThemeApp.primary,
          ),
        ));
  }
}
