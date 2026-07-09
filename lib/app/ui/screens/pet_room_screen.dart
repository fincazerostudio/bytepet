import 'package:flutter/material.dart';

import '../../../game/application/game_session.dart';
import '../../../game/data/pet_repository.dart';
import '../../../game/domain/entities/pet.dart';
import '../../../game/domain/entities/pet_species.dart';
import '../../../game/domain/rules/pet_action_type.dart';
import '../../../game/domain/services/time_engine.dart';
import '../developer_sandbox.dart';
import '../widgets/pet_status_card.dart';
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
              if (value == 'sandbox') {
                openSandbox();
              }

              if (value == 'reset') {
                resetSave();
              }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              speciesIcon(pet.species),
              style: const TextStyle(fontSize: 96),
            ),
            const SizedBox(height: 12),
            Text(
              pet.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              pet.species.name.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }
}
