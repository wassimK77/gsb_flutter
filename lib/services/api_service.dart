import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/appartement.dart';
import '../models/maison.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1";
  final Duration timeout = Duration(seconds: 10);

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<T> _handleRequest<T>(Future<http.Response> request, T Function(Map<String, dynamic>) parser) async {
    try {
      final response = await request.timeout(timeout);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        return parser(data);
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['error'] ?? 'Erreur HTTP ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Pas de connexion internet');
    } on FormatException {
      throw Exception('Réponse du serveur invalide');
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }

  Future<List<T>> _handleListRequest<T>(Future<http.Response> request, T Function(Map<String, dynamic>) parser) async {
    try {
      final response = await request.timeout(timeout);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => parser(item as Map<String, dynamic>)).toList();
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['error'] ?? 'Erreur HTTP ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('Pas de connexion internet');
    } on FormatException {
      throw Exception('Réponse du serveur invalide');
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }

  Future<List<Appartement>> fetchAppartements() async {
    return await _handleListRequest(
      http.get(Uri.parse("$baseUrl/appartements/apiList"), headers: _headers),
      (json) => Appartement.fromJson(json),
    );
  }

  Future<Appartement> fetchAppartementDetail(int id) async {
    return await _handleRequest(
      http.get(Uri.parse("$baseUrl/appartements/apiDetail/$id"), headers: _headers),
      (json) => Appartement.fromJson(json),
    );
  }

  Future<List<Maison>> fetchMaisons() async {
    return await _handleListRequest(
      http.get(Uri.parse("$baseUrl/maisons/apiList"), headers: _headers),
      (json) => Maison.fromJson(json),
    );
  }

  Future<Maison> fetchMaisonDetail(int id) async {
    return await _handleRequest(
      http.get(Uri.parse("$baseUrl/maisons/apiDetail/$id"), headers: _headers),
      (json) => Maison.fromJson(json),
    );
  }

  Future<Map<String, dynamic>> login(String login, String password) async {
    if (login.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Login et mot de passe requis');
    }

    return await _handleRequest(
      http.post(
        Uri.parse("$baseUrl/auth/apiLogin"),
        headers: _headers,
        body: json.encode({
          'login': login.trim(),
          'password': password.trim(),
        }),
      ),
      (json) => json,
    );
  }

  Future<Map<String, dynamic>> register({
    required String nom,
    required String prenom,
    required String adresse,
    required String codePostal,
    required String tel,
    required String login,
    required String password,
  }) async {
    // Validation côté client
    if (nom.trim().isEmpty || prenom.trim().isEmpty || login.trim().isEmpty || password.trim().isEmpty) {
      throw Exception('Nom, prénom, login et mot de passe sont requis');
    }

    if (password.length < 6) {
      throw Exception('Le mot de passe doit contenir au moins 6 caractères');
    }

    return await _handleRequest(
      http.post(
        Uri.parse("$baseUrl/auth/apiRegister"),
        headers: _headers,
        body: json.encode({
          'nom': nom.trim(),
          'prenom': prenom.trim(),
          'adresse': adresse.trim(),
          'codePostal': codePostal.trim(),
          'tel': tel.trim(),
          'login': login.trim(),
          'password': password.trim(),
        }),
      ),
      (json) => json,
    );
  }
}