import '../entities/pet.dart';

enum PetMood {
  happy,
  content,
  hungry,
  tired,
  dirty,
  unwell,
}

class MoodEngine {
  PetMood calculate(Pet pet) {
    if (pet.health.value <= 40) {
      return PetMood.unwell;
    }

    if (pet.hunger.value >= 70) {
      return PetMood.hungry;
    }

    if (pet.energy.value <= 30) {
      return PetMood.tired;
    }

    if (pet.cleanliness.value <= 30) {
      return PetMood.dirty;
    }

    if (pet.happiness.value >= 80 &&
        pet.hunger.value <= 35 &&
        pet.energy.value >= 60 &&
        pet.cleanliness.value >= 60) {
      return PetMood.happy;
    }

    return PetMood.content;
  }
}
