import 'package:flutter/material.dart';

class UserActions extends StatelessWidget {
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const UserActions({super.key, required this.onLogout, required this.onDeleteAccount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Vous pouvez vous déconnecter ici',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ElevatedButton(
          onPressed: onLogout,
          child: Text('Déconnexion'),
        ),
        SizedBox(height: 20),
        Text(
          'Vous pouvez supprimer votre compte ici',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ElevatedButton(
          onPressed: onDeleteAccount,
          child: Text('Supprimer mon compte'),
        ),
      ],
    );
  }
}