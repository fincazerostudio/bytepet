import '../domain/entities/pet.dart';
import '../domain/rules/pet_action_type.dart';
import '../domain/services/game_engine.dart';

class PetActions {
  final GameEngine _engine;

  const PetActions(this._engine);

  Pet feed(Pet pet) {
    return _engine.applyAction(pet, PetActionType.feed);
  }

  Pet play(Pet pet) {
    return _engine.applyAction(pet, PetActionType.play);
  }

  Pet rest(Pet pet) {
    return _engine.applyAction(pet, PetActionType.rest);
  }

  Pet clean(Pet pet) {
    return _engine.applyAction(pet, PetActionType.clean);
  }

  Pet giveMedicine(Pet pet) {
    return _engine.applyAction(pet, PetActionType.medicine);
  }
}
