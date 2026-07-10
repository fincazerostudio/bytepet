import 'package:flutter/material.dart';

import '../../../game/domain/entities/pet_species.dart';
import 'name_pet_screen.dart';

class StarterPetSelectionScreen extends StatelessWidget {
  const StarterPetSelectionScreen({super.key});

  void chooseStarter(
    BuildContext context, {
    required String icon,
    required String name,
    required PetSpecies species,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NamePetScreen(
          starterIcon: icon,
          starterName: name,
          species: species,
        ),
      ),
    );
  }

  Widget starterCard({
    required BuildContext context,
    required String icon,
    required String name,
    required String description,
    required PetSpecies species,
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
          species: species,
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
            icon: 'CAT',
            name: 'Cat',
            description: 'Grey fur, green eyes, and a white chest patch.',
            species: PetSpecies.cat,
          ),
          starterCard(
            context: context,
            icon: 'RP',
            name: 'Red Panda',
            description: 'Playful, curious, and full of mischief.',
            species: PetSpecies.redPanda,
          ),
          starterCard(
            context: context,
            icon: 'AX',
            name: 'Axolotl',
            description: 'Purple, aquatic, and wonderfully strange.',
            species: PetSpecies.axolotl,
          ),
        ],
      ),
    );
  }
}
