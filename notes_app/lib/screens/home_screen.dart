import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        actions: [
          TextButton(
            onPressed: auth.signOut,
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Text('Notes App', style: textTheme.headlineLarge),
            Text('Signed in as ${auth.user?.email ?? ''}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push('/notes'),
              child: const Text('Open my notes →'),
            ),
          ],
        ),
      ),
    );
  }
}