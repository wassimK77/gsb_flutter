import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/appartement.dart';
import 'appartement_detail_screen.dart';

class AppartementsListScreen extends StatefulWidget {
  const AppartementsListScreen({super.key});

  @override
  _AppartementsListScreenState createState() => _AppartementsListScreenState();
}

class _AppartementsListScreenState extends State<AppartementsListScreen> {
  final ApiService apiService = ApiService();
  List<Appartement> appartements = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadAppartements();
  }

  Future<void> loadAppartements() async {
    try {
      final loadedAppartements = await apiService.fetchAppartements();
      setState(() {
        appartements = loadedAppartements;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Appartements'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red),
                      SizedBox(height: 16),
                      Text('Erreur: $error'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            error = null;
                          });
                          loadAppartements();
                        },
                        child: Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : appartements.isEmpty
                  ? Center(child: Text('Aucun appartement trouvé'))
                  : ListView.builder(
                      itemCount: appartements.length,
                      itemBuilder: (context, index) {
                        final appartement = appartements[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(appartement.RUE),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${appartement.VILLE}, ${appartement.PAYS}'),
                                Text('Prix: ${appartement.PRIX_LOC}€'),
                                Text('Étage: ${appartement.ETAGE}'),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppartementDetailScreen(
                                    appartementId: appartement.NUMAPPART.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}