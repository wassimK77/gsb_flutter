import 'dart:convert';
import 'package:http/http.dart' as http;

enum UserType { visiteur, user, proprietaire }

class SessionData {
  final bool isLoggedIn;
  final UserType userType;
  final int? userId;
  final String? userName;
  final String? login;

  SessionData({
    required this.isLoggedIn,
    required this.userType,
    this.userId,
    this.userName,
    this.login,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) {
    UserType type = UserType.visiteur;
    switch (json['userType']) {
      case 'user':
        type = UserType.user;
        break;
      case 'proprietaire':
        type = UserType.proprietaire;
        break;
      default:
        type = UserType.visiteur;
        break;
    }

    return SessionData(
      isLoggedIn: json['isLoggedIn'] ?? false,
      userType: type,
      userId: json['userId'],
      userName: json['userName'],
      login: json['login'],
    );
  }

  // Session par défaut pour visiteur
  static SessionData get defaultSession => SessionData(
    isLoggedIn: false,
    userType: UserType.visiteur,
  );
}

class SessionService {
  final String baseUrl = "http://127.0.0.1";
  static SessionData? _currentSession;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<SessionData> getCurrentSession() async {
    if (_currentSession != null) {
      return _currentSession!;
    }

    try {
      final response = await http.get(
        Uri.parse("$baseUrl/session/apiGetSession"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _currentSession = SessionData.fromJson(data['session']);
          return _currentSession!;
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération de la session: $e');
    }

    _currentSession = SessionData.defaultSession;
    return _currentSession!;
  }

  Future<SessionData> login(String login, String password, UserType userType) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/apiLogin"),
        headers: _headers,
        body: json.encode({
          'login': login,
          'password': password,
          'userType': userType == UserType.proprietaire ? 'proprietaire' : 'user',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          _currentSession = SessionData(
            isLoggedIn: true,
            userType: data['userType'] == 'proprietaire' ? UserType.proprietaire : UserType.user,
            userId: data['user_id'],
            userName: data['login'],
            login: data['login'],
          );
          return _currentSession!;
        }
      }

      final errorData = json.decode(response.body);
      throw Exception(errorData['error'] ?? 'Erreur de connexion');
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<bool> logout() async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/session/apiLogout"),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        _currentSession = SessionData.defaultSession;
        return true;
      }
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    }

    return false;
  }

  Future<SessionData> register({
    required String nom,
    required String prenom,
    required String adresse,
    required String codePostal,
    required String tel,
    required String login,
    required String password,
    required UserType userType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/apiRegister"),
        headers: _headers,
        body: json.encode({
          'nom': nom,
          'prenom': prenom,
          'adresse': adresse,
          'codePostal': codePostal,
          'tel': tel,
          'login': login,
          'password': password,
          'userType': userType == UserType.proprietaire ? 'proprietaire' : 'user',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return SessionData.defaultSession; // Après inscription, rester visiteur
        }
      }

      final errorData = json.decode(response.body);
      throw Exception(errorData['error'] ?? 'Erreur d\'inscription');
    } catch (e) {
      throw Exception('Erreur d\'inscription: $e');
    }
  }

  void clearSession() {
    _currentSession = null;
  }
}