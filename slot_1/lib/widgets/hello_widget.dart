import 'package:flutter/material.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({
    super.key,
    this.message = 'Hello Flutter',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}