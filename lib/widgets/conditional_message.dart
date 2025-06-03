import 'package:flutter/material.dart';

class ConditionalMessage extends StatelessWidget {
  final String message;

  const ConditionalMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}