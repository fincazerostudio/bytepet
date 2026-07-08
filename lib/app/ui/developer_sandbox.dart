import 'package:flutter/material.dart';

class DeveloperSandbox extends StatelessWidget {
  const DeveloperSandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BytePet Developer Sandbox'),
      ),
      body: const Center(
        child: Text(
          'Sandbox Coming Soon',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
