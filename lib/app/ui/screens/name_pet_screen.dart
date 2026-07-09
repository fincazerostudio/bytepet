import 'package:flutter/material.dart';

import '../../../game/data/pet_repository.dart';
import '../../../game/domain/entities/pet.dart';
import '../../../game/domain/entities/stat.dart';
import '../developer_sandbox.dart';

class NamePetScreen extends StatefulWidget {
  final String starterName;
  final String starterIcon;

  const NamePetScreen({
    super.key,
    required this.starterName,
    required this.starterIcon,
  });

  @override
  State<NamePetScreen> createState() => _NamePetScreenState();
}

class _NamePetScreenState extends State<NamePetScreen> {
  final TextEditingController nameController = TextEditingController();
  final PetRepository repository = PetRepository();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> continueToRoom() async {
    final petName = nameController.text.trim();

    if (petName.isEmpty) {
      return;
    }

    final now = DateTime.now();

    final pet = Pet(
      name: petName,
      growthStage: GrowthStage.baby,
      hunger: Stat(25),
      happiness: Stat(85),
      energy: Stat(90),
      health: Stat(100),
      cleanliness: Stat(95),
      createdAt: now,
      lastUpdatedAt: now,
    );

    await repository.savePet(pet);

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const DeveloperSandbox(),
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name Your Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.starterIcon,
              style: const TextStyle(fontSize: 72),
            ),
            const SizedBox(height: 12),
            Text(
              widget.starterName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 28),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Pet Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: continueToRoom,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
