import 'package:flutter/material.dart';

class MaisonRequestScreen extends StatelessWidget {
  const MaisonRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande de Maison'),
      ),
      body: Center(
        child: Text('Formulaire pour demander une maison.'),
      ),
    );
  }
}