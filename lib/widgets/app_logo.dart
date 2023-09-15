import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;

  const AppLogo({
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: SizedBox(
        height: height,
        child: const Image(
          image: AssetImage(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}
