import 'package:flutter/material.dart';

import '../../game/domain/entities/pet.dart';
import '../../game/domain/entities/stat.dart';
import 'widgets/pet_status_card.dart';

class DeveloperSandbox extends StatelessWidget {
  const DeveloperSandbox({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = Pet(
      name: 'Byte',
      growthStage: GrowthStage.baby,
      hunger: Stat(75),
      happiness: Stat(90),
      energy: Stat(85),
      health: Stat(100),
      cleanliness: Stat(95),
      createdAt: DateTime.now(),
      lastUpdatedAt: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('BytePet Developer Sandbox'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: PetStatusCard(pet: pet),
      ),
    );
  }
}
