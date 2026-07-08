import '../domain/entities/pet.dart';

class PetActions {
  Pet feed(Pet pet) {
    return pet.copyWith(
      hunger: pet.hunger.decrease(20),
      happiness: pet.happiness.increase(5),
      lastUpdatedAt: DateTime.now(),
    );
  }

  Pet play(Pet pet) {
    return pet.copyWith(
      happiness: pet.happiness.increase(15),
      energy: pet.energy.decrease(10),
      hunger: pet.hunger.increase(10),
      cleanliness: pet.cleanliness.decrease(5),
      lastUpdatedAt: DateTime.now(),
    );
  }

  Pet rest(Pet pet) {
    return pet.copyWith(
      energy: pet.energy.increase(25),
      happiness: pet.happiness.decrease(3),
      lastUpdatedAt: DateTime.now(),
    );
  }

  Pet clean(Pet pet) {
    return pet.copyWith(
      cleanliness: pet.cleanliness.increase(30),
      happiness: pet.happiness.increase(5),
      lastUpdatedAt: DateTime.now(),
    );
  }

  Pet giveMedicine(Pet pet) {
    return pet.copyWith(
      health: pet.health.increase(25),
      happiness: pet.happiness.decrease(5),
      lastUpdatedAt: DateTime.now(),
    );
  }
}
