
import 'package:flutter/material.dart';

class MaisonsListScreen extends StatelessWidget {
  const MaisonsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Maisons'),
      ),
      body: const Center(
        child: Text('Maisons will go here!'),
      ),
    );
  }
}