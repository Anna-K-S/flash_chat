import 'package:flutter/material.dart';

class LogoDecoration {
  final double height;

  LogoDecoration({required this.height});

  late final logo = Hero(
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
