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
      home: const DeveloperSandbox(),
    );
  }
}
