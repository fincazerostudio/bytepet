import 'package:flutter/material.dart';

import '../../../game/data/pet_repository.dart';
import 'pet_room_screen.dart';
import 'welcome_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  final PetRepository repository = PetRepository();

  @override
  void initState() {
    super.initState();
    checkForSavedPet();
  }

  Future<void> checkForSavedPet() async {
    final savedPet = await repository.loadPet();

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          if (savedPet != null) {
            return const PetRoomScreen();
          }

          return const WelcomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
