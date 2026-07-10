import 'package:flutter/material.dart';

import '../../../game/application/game_session.dart';
import '../../../game/data/pet_repository.dart';
import '../../../game/domain/entities/pet.dart';
import '../../../game/domain/rules/pet_action_type.dart';
import '../../../game/domain/services/mood_engine.dart';
import '../../../game/domain/services/pet_sprite_resolver.dart';
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
  String petReaction = '';

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
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );

      return;
    }

    final timeEngine = TimeEngine.standard();
    final updatedPet = timeEngine.progress(
      savedPet,
      DateTime.now(),
    );

    session = GameSession(
      pet: updatedPet,
      petRepository: repository,
      timeEngine: timeEngine,
    );

    await session.save();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  Future<void> action(
    PetActionType actionType,
    String reaction,
  ) async {
    await session.performAction(actionType);

    if (!mounted) return;

    setState(() {
      petReaction = reaction;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    if (petReaction == reaction) {
      setState(() {
        petReaction = '';
      });
    }
  }

  Future<void> resetSave() async {
    await repository.clearPet();

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      ),
      (_) => false,
    );
  }

  void openSandbox() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const DeveloperSandbox(),
      ),
    );
  }

  Widget miniStat(
    String label,
    int value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 3),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(
    String label,
    PetActionType actionType,
    String reaction,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => action(
            actionType,
            reaction,
          ),
          child: Text(label),
        ),
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

    final Pet pet = session.pet;
    final mood = MoodEngine().calculate(pet);

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/rooms/homelab_room.png',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.none,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Colors.black38,
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                          pet.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 6,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          pet.species.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mood: ${mood.name}',
                          style: const TextStyle(
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 42,
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          child: petReaction.isEmpty
                              ? const SizedBox(
                                  height: 42,
                                )
                              : Container(
                                  key: ValueKey(
                                    petReaction,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(
                                      18,
                                    ),
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: Text(
                                    petReaction,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),

                        const SizedBox(height: 4),

                        Image.asset(
                          PetSpriteResolver.idle(
                            pet.species,
                          ),
                          width: 230,
                          height: 230,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              color: const Color(0xFF101014),
              padding: const EdgeInsets.fromLTRB(
                12,
                10,
                12,
                14,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      miniStat(
                        'Full',
                        100 - pet.hunger.value,
                      ),
                      miniStat(
                        'Happy',
                        pet.happiness.value,
                      ),
                      miniStat(
                        'Energy',
                        pet.energy.value,
                      ),
                      miniStat(
                        'Clean',
                        pet.cleanliness.value,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      actionButton(
                        'Feed',
                        PetActionType.feed,
                        'Yum!',
                      ),
                      actionButton(
                        'Play',
                        PetActionType.play,
                        'Again! Again!',
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      actionButton(
                        'Sleep',
                        PetActionType.rest,
                        'So sleepy...',
                      ),
                      actionButton(
                        'Clean',
                        PetActionType.clean,
                        'Squeaky clean!',
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      actionButton(
                        'Medicine',
                        PetActionType.medicine,
                        'Yuck... but I feel better.',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
