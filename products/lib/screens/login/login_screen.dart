import 'package:flutter/material.dart';
import 'package:products/screens/screens.dart';
import 'package:products/widgets/card_container.dart';

class LoginScreen extends StatelessWidget {
  //Parametes.

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //global variables.

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBackground(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_pin,
                  size: size.width * 0.25, color: Colors.white),
              SizedBox(height: size.height * 0.045),
              CardContainer(
                child: Column(
                  children: [
                    Text("data"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
