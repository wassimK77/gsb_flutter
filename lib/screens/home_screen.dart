import 'package:flutter/material.dart';
import '../services/session_service.dart';
import '../widgets/home_title.dart';
import '../widgets/action_buttons.dart';
import '../widgets/conditional_message.dart';
import '../widgets/user_actions.dart';
import '../widgets/proprio_actions.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'appartements/appartements_list_screen.dart';
import 'maison_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionService _sessionService = SessionService();
  SessionData? _sessionData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    try {
      final session = await _sessionService.getCurrentSession();
      setState(() {
        _sessionData = session;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _sessionData = SessionData.defaultSession;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    final success = await _sessionService.logout();
    if (success) {
      setState(() {
        _sessionData = SessionData.defaultSession;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Déconnexion réussie')),
      );
    }
  }

  Future<void> _handleDeleteAccount() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer la suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer votre compte ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implémenter la suppression du compte via API
              _handleLogout();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Compte supprimé')),
              );
            },
            child: Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Site de location d\'appartements'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final session = _sessionData!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Site de location d\'appartements'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeTitle(
                  title: 'Site de location d\'appartements',
                  subtitle: 'Page d\'accueil',
                ),
                SizedBox(height: 20),
                _buildWelcomeMessage(session),
                SizedBox(height: 20),
                ConditionalMessage(message: 'Que souhaitez-vous faire ?'),
                SizedBox(height: 20),
                _buildActionButtons(session),
                SizedBox(height: 20),
                _buildUserActions(session),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage(SessionData session) {
    if (session.isLoggedIn && session.userName != null) {
      String userTypeText = session.userType == UserType.proprietaire ? 'Propriétaire' : 'Utilisateur';
      return ConditionalMessage(
        message: 'Bienvenue ${session.userName} ($userTypeText)',
      );
    }
    return ConditionalMessage(message: 'Bienvenue, Visiteur');
  }

  Widget _buildActionButtons(SessionData session) {
    if (session.userType == UserType.user) {
      return ActionButtons(
        actions: [
          {
            'label': 'Liste des appartements',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppartementsListScreen(),
                ),
              );
            },
          },
          {
            'label': 'Liste des maisons',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaisonsListScreen(),
                ),
              );
            },
          },
        ],
      );
    } else if (session.userType == UserType.proprietaire) {
      return ActionButtons(
        actions: [
          {
            'label': 'Location de votre appartement',
            'onPressed': () {
              // TODO: Naviguer vers la location d'appartements
            },
          },
          {
            'label': 'Location de votre maison',
            'onPressed': () {
              // TODO: Naviguer vers la location de maisons
            },
          },
          {
            'label': 'Consulter les appartements',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppartementsListScreen(),
                ),
              );
            },
          },
          {
            'label': 'Consulter les maisons',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MaisonsListScreen(),
                ),
              );
            },
          },
        ],
      );
    } else {
      return ActionButtons(
        actions: [
          {
            'label': 'Connexion Utilisateur',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(userType: UserType.user),
                ),
              ).then((_) => _loadSession());
            },
          },
          {
            'label': 'Connexion Propriétaire',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(userType: UserType.proprietaire),
                ),
              ).then((_) => _loadSession());
            },
          },
          {
            'label': 'Inscription Utilisateur',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(userType: UserType.user),
                ),
              ).then((_) => _loadSession());
            },
          },
          {
            'label': 'Inscription Propriétaire',
            'onPressed': () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(userType: UserType.proprietaire),
                ),
              ).then((_) => _loadSession());
            },
          },
        ],
      );
    }
  }

  Widget _buildUserActions(SessionData session) {
    if (session.userType == UserType.user) {
      return UserActions(
        onLogout: _handleLogout,
        onDeleteAccount: _handleDeleteAccount,
      );
    } else if (session.userType == UserType.proprietaire) {
      return ProprioActions(
        onLogout: _handleLogout,
      );
    }
    return SizedBox.shrink();
  }
}
