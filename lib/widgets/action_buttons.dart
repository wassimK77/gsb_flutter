import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final List<Map<String, dynamic>> actions;

  const ActionButtons({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: actions.map((action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ElevatedButton(
            onPressed: action['onPressed'],
            child: Text(action['label']),
          ),
        );
      }).toList(),
    );
  }
}