import '../data/pet_repository.dart';
import '../domain/entities/pet.dart';
import '../domain/rules/pet_action_type.dart';
import '../domain/services/game_engine.dart';
import '../domain/services/time_engine.dart';

class GameSession {
  Pet pet;

  final GameEngine gameEngine;
  final TimeEngine timeEngine;
  final PetRepository petRepository;

  GameSession({
    required this.pet,
    GameEngine? gameEngine,
    TimeEngine? timeEngine,
    PetRepository? petRepository,
  })  : gameEngine = gameEngine ?? GameEngine(),
        timeEngine = timeEngine ?? TimeEngine.standard(),
        petRepository = petRepository ?? PetRepository();

  Future<void> performAction(PetActionType action) async {
    pet = gameEngine.applyAction(pet, action);
    await petRepository.savePet(pet);
  }

  Future<void> advanceMinutes(int minutes) async {
    final futureTime = pet.lastUpdatedAt.add(Duration(minutes: minutes));
    pet = timeEngine.progress(pet, futureTime);
    await petRepository.savePet(pet);
  }

  Future<void> save() async {
    await petRepository.savePet(pet);
  }
}
