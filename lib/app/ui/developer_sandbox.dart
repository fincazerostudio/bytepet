import 'package:flutter/material.dart';

import '../../game/application/game_session.dart';
import '../../game/data/pet_repository.dart';
import '../../game/domain/entities/pet.dart';
import '../../game/domain/entities/stat.dart';
import '../../game/domain/entities/pet_species.dart';
import '../../game/domain/rules/pet_action_type.dart';
import '../../game/domain/services/time_engine.dart';
import 'widgets/pet_status_card.dart';

class DeveloperSandbox extends StatefulWidget {
  const DeveloperSandbox({super.key});

  @override
  State<DeveloperSandbox> createState() => _DeveloperSandboxState();
}

class _DeveloperSandboxState extends State<DeveloperSandbox> {
  final PetRepository repository = PetRepository();
  late GameSession session;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  Pet createStarterPet() {
    final now = DateTime.now();

    return Pet(
      name: 'Byte',
      species: PetSpecies.cat,
        growthStage: GrowthStage.baby,
      hunger: Stat(75),
      happiness: Stat(90),
      energy: Stat(85),
      health: Stat(100),
      cleanliness: Stat(95),
      createdAt: now,
      lastUpdatedAt: now,
    );
  }

  Future<void> loadSession() async {
    final savedPet = await repository.loadPet();
    final timeEngine = TimeEngine.standard();

    final pet = savedPet == null
        ? createStarterPet()
        : timeEngine.progress(savedPet, DateTime.now());

    session = GameSession(
      pet: pet,
      petRepository: repository,
      timeEngine: timeEngine,
    );

    await session.save();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> action(PetActionType actionType) async {
    await session.performAction(actionType);
    setState(() {});
  }

  Future<void> advance(int minutes) async {
    await session.advanceMinutes(minutes);
    setState(() {});
  }

  Future<void> resetPet() async {
    session = GameSession(
      pet: createStarterPet(),
      petRepository: repository,
      timeEngine: TimeEngine.standard(),
    );

    await session.save();

    setState(() {});
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
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                button('Reset Pet', resetPet),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
