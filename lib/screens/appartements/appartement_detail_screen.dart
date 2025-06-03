import 'package:flutter/material.dart';

class AppartementDetailScreen extends StatelessWidget {
  final String appartementId;

  const AppartementDetailScreen({super.key, required this.appartementId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de l\'Appartement'),
      ),
      body: Center(
        child: Text('Détails pour l\'appartement ID : $appartementId'),
      ),
    );
  }
}