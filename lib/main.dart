import 'package:flutter/material.dart';
import 'package:rickandmortyapp/screens/character_screen.dart';
import 'package:rickandmortyapp/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => HomeScreen(), routes: [
    GoRoute(path: 'character', builder: (context, state) => CharacterScreen())
  ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
