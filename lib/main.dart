import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AussiePartsFinderApp());
}

class AussiePartsFinderApp extends StatelessWidget {
  const AussiePartsFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aussie PartsFinder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8A00),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F1115),
      ),
      home: const HomeScreen(),
    );
  }
}
