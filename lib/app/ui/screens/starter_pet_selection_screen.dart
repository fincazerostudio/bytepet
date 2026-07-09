import 'package:flutter/material.dart';

import 'name_pet_screen.dart';

class StarterPetSelectionScreen extends StatelessWidget {
  const StarterPetSelectionScreen({super.key});

  void chooseStarter(
    BuildContext context, {
    required String icon,
    required String name,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NamePetScreen(
          starterIcon: icon,
          starterName: name,
        ),
      ),
    );
  }

  Widget starterCard({
    required BuildContext context,
    required String icon,
    required String name,
    required String description,
  }) {
    return Card(
      child: ListTile(
        leading: Text(
          icon,
          style: const TextStyle(fontSize: 36),
        ),
        title: Text(name),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => chooseStarter(
          context,
          icon: icon,
          name: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Starter'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Pick your first companion.',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          starterCard(
            context: context,
            icon: '??',
            name: 'Cat',
            description: 'Calm, curious, and cozy.',
          ),
          starterCard(
            context: context,
            icon: '??',
            name: 'Fox',
            description: 'Playful, clever, and energetic.',
          ),
          starterCard(
            context: context,
            icon: '??',
            name: 'Rabbit',
            description: 'Gentle, sweet, and affectionate.',
          ),
        ],
      ),
    );
  }
}
