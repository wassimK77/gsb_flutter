import 'package:flutter/material.dart';
import '../services/session_service.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_message.dart';

class LoginScreen extends StatefulWidget {
  final UserType userType;

  const LoginScreen({super.key, required this.userType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final SessionService _sessionService = SessionService();
  
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateLogin(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le login est requis';
    }
    if (value.trim().length < 3) {
      return 'Le login doit contenir au moins 3 caractères';
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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _sessionService.login(
        _loginController.text.trim(),
        _passwordController.text,
        widget.userType,
      );

      Navigator.pop(context, true); // Retourner true pour indiquer succès
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

  @override
  Widget build(BuildContext context) {
    String userTypeText = widget.userType == UserType.proprietaire ? 'Propriétaire' : 'Utilisateur';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion $userTypeText'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'Connexion $userTypeText',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              if (_errorMessage != null) ...[
                ErrorMessage(message: _errorMessage!),
                SizedBox(height: 20),
              ],
              CustomInputField(
                label: 'Login',
                controller: _loginController,
                validator: _validateLogin,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 20),
              CustomInputField(
                label: 'Mot de passe',
                controller: _passwordController,
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 30),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Se connecter',
                      onPressed: _handleLogin,
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Retour à l\'accueil',
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