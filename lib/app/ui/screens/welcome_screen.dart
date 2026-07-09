import 'package:flutter/material.dart';

import '../developer_sandbox.dart';
import 'starter_pet_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void openSandbox(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DeveloperSandbox(),
      ),
    );
  }

  void startNewPet(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const StarterPetSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BytePet',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'A tiny companion that grows with you.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => startNewPet(context),
                child: const Text('Start New Pet'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => openSandbox(context),
                child: const Text('Developer Sandbox'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
