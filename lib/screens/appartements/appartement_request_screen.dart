import 'package:flutter/material.dart';

class AppartementRequestScreen extends StatelessWidget {
  const AppartementRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande d\'Appartement'),
      ),
      body: Center(
        child: Text('Formulaire pour demander un appartement.'),
      ),
    );
  }
}