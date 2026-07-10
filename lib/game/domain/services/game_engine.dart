import '../entities/pet.dart';
import '../rules/pet_action_type.dart';

class GameEngine {
  Pet applyAction(Pet pet, PetActionType actionType) {
    final now = DateTime.now();

    switch (actionType) {
      case PetActionType.feed:
        return pet.copyWith(
          hunger: pet.hunger.decrease(8),
          happiness: pet.happiness.increase(2),
          lastUpdatedAt: now,
        );

      case PetActionType.play:
        return pet.copyWith(
          happiness: pet.happiness.increase(6),
          energy: pet.energy.decrease(4),
          hunger: pet.hunger.increase(3),
          cleanliness: pet.cleanliness.decrease(2),
          lastUpdatedAt: now,
        );

      case PetActionType.rest:
        return pet.copyWith(
          energy: pet.energy.increase(10),
          happiness: pet.happiness.decrease(1),
          lastUpdatedAt: now,
        );

      case PetActionType.clean:
        return pet.copyWith(
          cleanliness: pet.cleanliness.increase(12),
          happiness: pet.happiness.increase(2),
          lastUpdatedAt: now,
        );

      case PetActionType.medicine:
        return pet.copyWith(
          health: pet.health.increase(10),
          happiness: pet.happiness.decrease(2),
          lastUpdatedAt: now,
        );
    }
  }
}
