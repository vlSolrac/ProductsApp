import 'package:flutter/material.dart';
import 'package:products/widgets/widgets.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            
            width: double.infinity,
            height: size.height * 0.4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(63, 63, 156, 1),
                  Color.fromRGBO(90, 70, 178, 1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    bottom: 30,
                    left: 170,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    top: -20,
                    left: -30,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    bottom: -10,
                    right: -30,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(top: 150, child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    top: 50,
                    left: 150,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    bottom: -30,
                    left: 30,
                    child: Bubble(radius: size.width * 0.095)),
                Positioned(
                    bottom: 120,
                    right: 20,
                    child: Bubble(radius: size.width * 0.095)),
              ],
            ),
          ),
          child
        ],
      ),
    );
  }
}

