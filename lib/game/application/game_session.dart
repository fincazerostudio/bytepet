import '../domain/entities/pet.dart';
import '../domain/rules/pet_action_type.dart';
import '../domain/services/game_engine.dart';
import '../domain/services/time_engine.dart';

class GameSession {
  Pet pet;

  final GameEngine gameEngine;
  final TimeEngine timeEngine;

  GameSession({
    required this.pet,
    GameEngine? gameEngine,
    TimeEngine? timeEngine,
  })  : gameEngine = gameEngine ?? GameEngine(),
        timeEngine = timeEngine ?? TimeEngine.standard();

  void performAction(PetActionType action) {
    pet = gameEngine.applyAction(pet, action);
  }

  void advanceMinutes(int minutes) {
    final futureTime = pet.lastUpdatedAt.add(Duration(minutes: minutes));
    pet = timeEngine.progress(pet, futureTime);
  }
}
