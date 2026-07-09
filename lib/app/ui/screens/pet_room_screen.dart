import 'package:flutter/material.dart';

import '../../../game/application/game_session.dart';
import '../../../game/data/pet_repository.dart';
import '../../../game/domain/entities/pet.dart';
import '../../../game/domain/entities/pet_species.dart';
import '../../../game/domain/rules/pet_action_type.dart';
import '../../../game/domain/services/time_engine.dart';
import '../developer_sandbox.dart';
import 'welcome_screen.dart';

class PetRoomScreen extends StatefulWidget {
  const PetRoomScreen({super.key});

  @override
  State<PetRoomScreen> createState() => _PetRoomScreenState();
}

class _PetRoomScreenState extends State<PetRoomScreen> {
  final PetRepository repository = PetRepository();
  late GameSession session;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPet();
  }

  Future<void> loadPet() async {
    final savedPet = await repository.loadPet();

    if (savedPet == null) {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
      return;
    }

    final timeEngine = TimeEngine.standard();
    final updatedPet = timeEngine.progress(savedPet, DateTime.now());

    session = GameSession(
      pet: updatedPet,
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

  Future<void> resetSave() async {
    await repository.clearPet();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (_) => false,
    );
  }

  void openSandbox() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DeveloperSandbox()),
    );
  }

  String speciesIcon(PetSpecies species) {
    switch (species) {
      case PetSpecies.cat:
        return '??';
      case PetSpecies.fox:
        return '??';
      case PetSpecies.rabbit:
        return '??';
    }
  }

  Widget actionButton(String label, PetActionType actionType) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => action(actionType),
          child: Text(label),
        ),
      ),
    );
  }

  Widget miniStat(String label, int value) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 4),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final Pet pet = session.pet;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Room'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'sandbox') openSandbox();
              if (value == 'reset') resetSave();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'sandbox',
                child: Text('Developer Sandbox'),
              ),
              PopupMenuItem(
                value: 'reset',
                child: Text('Reset Save'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              pet.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            Text(
              pet.species.name.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),

            const Spacer(),

            Text(
              speciesIcon(pet.species),
              style: const TextStyle(fontSize: 120),
            ),

            const Spacer(),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    miniStat('Full', 100 - pet.hunger.value),
                    miniStat('Happy', pet.happiness.value),
                    miniStat('Energy', pet.energy.value),
                    miniStat('Clean', pet.cleanliness.value),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      actionButton('Feed', PetActionType.feed),
                      actionButton('Play', PetActionType.play),
                    ],
                  ),
                  Row(
                    children: [
                      actionButton('Sleep', PetActionType.rest),
                      actionButton('Clean', PetActionType.clean),
                    ],
                  ),
                  Row(
                    children: [
                      actionButton('Medicine', PetActionType.medicine),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
