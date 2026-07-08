import '../entities/pet.dart';

class TimeEngine {
  static const int minutesPerTick = 15;

  Pet progress(Pet pet, DateTime now) {
    final elapsedMinutes = now.difference(pet.lastUpdatedAt).inMinutes;

    if (elapsedMinutes < minutesPerTick) {
      return pet;
    }

    final ticks = elapsedMinutes ~/ minutesPerTick;

    return pet.copyWith(
      hunger: pet.hunger.increase(ticks * 2),
      energy: pet.energy.decrease(ticks),
      cleanliness: pet.cleanliness.decrease(ticks),
      happiness: pet.happiness.decrease(ticks),
      lastUpdatedAt: now,
    );
  }
}
