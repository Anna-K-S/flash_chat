import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color color;

  const RoundedButton({
    required this.onPressed,
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(
          30.0,
        ),
        child: MaterialButton(
          onPressed: () => onPressed(),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    
  }
}
