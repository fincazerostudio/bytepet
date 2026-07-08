import '../entities/pet.dart';
import '../rules/pet_action_type.dart';

class GameEngine {
  Pet applyAction(Pet pet, PetActionType actionType) {
    final now = DateTime.now();

    switch (actionType) {
      case PetActionType.feed:
        return pet.copyWith(
          hunger: pet.hunger.decrease(20),
          happiness: pet.happiness.increase(5),
          lastUpdatedAt: now,
        );

      case PetActionType.play:
        return pet.copyWith(
          happiness: pet.happiness.increase(15),
          energy: pet.energy.decrease(10),
          hunger: pet.hunger.increase(10),
          cleanliness: pet.cleanliness.decrease(5),
          lastUpdatedAt: now,
        );

      case PetActionType.rest:
        return pet.copyWith(
          energy: pet.energy.increase(25),
          happiness: pet.happiness.decrease(3),
          lastUpdatedAt: now,
        );

      case PetActionType.clean:
        return pet.copyWith(
          cleanliness: pet.cleanliness.increase(30),
          happiness: pet.happiness.increase(5),
          lastUpdatedAt: now,
        );

      case PetActionType.medicine:
        return pet.copyWith(
          health: pet.health.increase(25),
          happiness: pet.happiness.decrease(5),
          lastUpdatedAt: now,
        );
    }
  }
}
