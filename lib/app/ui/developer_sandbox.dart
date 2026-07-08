import 'package:flutter/material.dart';

import '../../game/application/game_session.dart';
import '../../game/domain/entities/pet.dart';
import '../../game/domain/entities/stat.dart';
import '../../game/domain/rules/pet_action_type.dart';
import 'widgets/pet_status_card.dart';

class DeveloperSandbox extends StatefulWidget {
  const DeveloperSandbox({super.key});

  @override
  State<DeveloperSandbox> createState() => _DeveloperSandboxState();
}

class _DeveloperSandboxState extends State<DeveloperSandbox> {
  late GameSession session;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    session = GameSession(
      pet: Pet(
        name: 'Byte',
        growthStage: GrowthStage.baby,
        hunger: Stat(75),
        happiness: Stat(90),
        energy: Stat(85),
        health: Stat(100),
        cleanliness: Stat(95),
        createdAt: now,
        lastUpdatedAt: now,
      ),
    );
  }

  void action(PetActionType actionType) {
    setState(() {
      session.performAction(actionType);
    });
  }

  void advance(int minutes) {
    setState(() {
      session.advanceMinutes(minutes);
    });
  }

  Widget button(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pet = session.pet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BytePet Developer Sandbox'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PetStatusCard(pet: pet),

            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              children: [
                button('Feed', () => action(PetActionType.feed)),
                button('Play', () => action(PetActionType.play)),
                button('Sleep', () => action(PetActionType.rest)),
                button('Clean', () => action(PetActionType.clean)),
                button('Medicine', () => action(PetActionType.medicine)),
              ],
            ),

            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              children: [
                button('+15 Min', () => advance(15)),
                button('+1 Hour', () => advance(60)),
                button('+1 Day', () => advance(1440)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
