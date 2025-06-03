import 'package:flutter/material.dart';

class MaisonDetailScreen extends StatelessWidget {
  final String maisonId;

  const MaisonDetailScreen({super.key, required this.maisonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Maison'),
      ),
      body: Center(
        child: Text('Détails pour la maison ID : $maisonId'),
      ),
    );
  }
}