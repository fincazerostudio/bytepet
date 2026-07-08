import '../entities/pet.dart';
import 'simulation_engine.dart';

class TimeEngine {
  static const int minutesPerTick = 15;

  final SimulationEngine simulationEngine;

  const TimeEngine({
    required this.simulationEngine,
  });

  factory TimeEngine.standard() {
    return TimeEngine(
      simulationEngine: SimulationEngine.standard(),
    );
  }

  Pet progress(Pet pet, DateTime now) {
    final elapsedMinutes = now.difference(pet.lastUpdatedAt).inMinutes;

    if (elapsedMinutes < minutesPerTick) {
      return pet;
    }

    final ticks = elapsedMinutes ~/ minutesPerTick;

    return simulationEngine.applyTimeProgression(pet, ticks, now);
  }
}
