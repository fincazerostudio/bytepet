import 'package:flutter/material.dart';
import 'app/ui/developer_sandbox.dart';

void main() {
  runApp(const BytePetApp());
}

class BytePetApp extends StatelessWidget {
  const BytePetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BytePet',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101014),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF15151C),
          foregroundColor: Colors.white,
        ),
      ),
      home: const DeveloperSandbox(),
    );
  }
}
