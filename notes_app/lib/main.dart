import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/notes_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // init() restaure la session mémorisée par le SDK
      create: (_) => AuthProvider(AuthService())..init(),
      child: const NotesApp(),
    ),
  );
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Le routeur est créé une seule fois, pas à chaque build
    final auth = context.read<AuthProvider>();
    _router = GoRouter(
      initialLocation: '/splash',
      refreshListenable: auth, // re-exécute redirect à chaque notifyListeners()
      redirect: (context, state) {
        final location = state.matchedLocation;

        if (auth.initializing) {
          return location == '/splash' ? null : '/splash';
        }
        if (auth.user == null) {
          return location == '/login' ? null : '/login';
        }
        if (location == '/login' || location == '/splash') return '/';
        return null;
      },
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        ),
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/notes', builder: (context, state) => const NotesScreen()),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Notes App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF208AEF)),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF208AEF),
        brightness: Brightness.dark,
      ),
      routerConfig: _router,
    );
  }
}