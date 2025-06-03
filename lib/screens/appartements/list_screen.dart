import 'package:flutter/material.dart';
import 'package:flutter_app/services/api_service.dart';
import 'package:flutter_app/models/appartement.dart';

class AppartementListScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  AppartementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liste des Appartements")),
      body: FutureBuilder<List<Appartement>>(
        future: apiService.fetchAppartements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else {
            final appartements = snapshot.data!;
            return ListView.builder(
              itemCount: appartements.length,
              itemBuilder: (context, index) {
                final appartement = appartements[index];
                return ListTile(
                  title: Text(appartement.RUE),
                  subtitle: Text("${appartement.VILLE}, ${appartement.REGION}"),
                  trailing: Text("${appartement.PRIX_LOC} €"),
                  onTap: () {
                    // Naviguer vers l'écran de détail
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}