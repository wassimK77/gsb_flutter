import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/maison.dart';
import 'maisons/maison_detail_screen.dart';

class MaisonsListScreen extends StatefulWidget {
  const MaisonsListScreen({super.key});

  @override
  _MaisonsListScreenState createState() => _MaisonsListScreenState();
}

class _MaisonsListScreenState extends State<MaisonsListScreen> {
  final ApiService apiService = ApiService();
  List<Maison> maisons = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadMaisons();
  }

  Future<void> loadMaisons() async {
    try {
      final loadedMaisons = await apiService.fetchMaisons();
      setState(() {
        maisons = loadedMaisons;
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
        title: Text('Liste des Maisons'),
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
                          loadMaisons();
                        },
                        child: Text('Réessayer'),
                      ),
                    ],
                  ),
                )
              : maisons.isEmpty
                  ? Center(child: Text('Aucune maison trouvée'))
                  : ListView.builder(
                      itemCount: maisons.length,
                      itemBuilder: (context, index) {
                        final maison = maisons[index];
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(maison.RUE),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${maison.VILLE}, ${maison.PAYS}'),
                                Text('Prix: ${maison.PRIX_LOC}€'),
                                Text('Superficie: ${maison.SUPERFICIE}m²'),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MaisonDetailScreen(
                                    maisonId: maison.NUM_MAISON.toString(),
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