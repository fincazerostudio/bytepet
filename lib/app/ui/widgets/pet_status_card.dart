import 'package:flutter/material.dart';

import '../../../game/domain/entities/pet.dart';

class PetStatusCard extends StatelessWidget {
  final Pet pet;

  const PetStatusCard({
    super.key,
    required this.pet,
  });

  Widget stat(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 12,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 36,
            child: Text(
              '$value',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              pet.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            Text(
              pet.growthStage.name.toUpperCase(),
            ),

            const SizedBox(height: 20),

            stat("❤️ Health", pet.health.value),
            stat("🍖 Hunger", pet.hunger.value),
            stat("😊 Happiness", pet.happiness.value),
            stat("😴 Energy", pet.energy.value),
            stat("🧼 Cleanliness", pet.cleanliness.value),
          ],
        ),
      ),
    );
  }
}
