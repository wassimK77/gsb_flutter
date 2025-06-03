import 'package:flutter/material.dart';

class ProprioActions extends StatelessWidget {
  final VoidCallback onLogout;

  const ProprioActions({super.key, required this.onLogout});

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
      ],
    );
  }
}