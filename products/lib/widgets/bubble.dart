import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final double radius;
  const Bubble({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.05),
    );
  }
}
