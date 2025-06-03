import 'package:flutter/material.dart';
import '../services/session_service.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_message.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final UserType userType;
  
  const RegisterScreen({super.key, required this.userType});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _adresseController = TextEditingController();
  final _codePostalController = TextEditingController();
  final _telController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  final SessionService _sessionService = SessionService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _adresseController.dispose();
    _codePostalController.dispose();
    _telController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmez votre mot de passe';
    }
    if (value != _passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _sessionService.register(
        nom: _nomController.text.trim(),
        prenom: _prenomController.text.trim(),
        adresse: _adresseController.text.trim(),
        codePostal: _codePostalController.text.trim(),
        tel: _telController.text.trim(),
        login: _loginController.text.trim(),
        password: _passwordController.text,
        userType: widget.userType,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Inscription réussie ! Vous pouvez maintenant vous connecter.'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(userType: widget.userType),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String get _userTypeText {
    return widget.userType == UserType.proprietaire ? 'Propriétaire' : 'Utilisateur';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription $_userTypeText'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Créer un compte $_userTypeText',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              if (_errorMessage != null) ...[
                ErrorMessage(message: _errorMessage!),
                SizedBox(height: 20),
              ],
              CustomInputField(
                label: 'Nom*',
                controller: _nomController,
                validator: (value) => _validateRequired(value, 'Le nom'),
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Prénom*',
                controller: _prenomController,
                validator: (value) => _validateRequired(value, 'Le prénom'),
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Adresse',
                controller: _adresseController,
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Code postal',
                controller: _codePostalController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Téléphone',
                controller: _telController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Login*',
                controller: _loginController,
                validator: (value) => _validateRequired(value, 'Le login'),
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Mot de passe*',
                controller: _passwordController,
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 15),
              CustomInputField(
                label: 'Confirmer le mot de passe*',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: _validateConfirmPassword,
              ),
              SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'S\'inscrire',
                      onPressed: _handleRegister,
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Déjà inscrit ? Se connecter',
                  style: TextStyle(color: Color(0xFF4CAF50)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}