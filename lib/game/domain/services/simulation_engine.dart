import '../entities/pet.dart';
import '../rules/cleanliness_rule.dart';
import '../rules/energy_rule.dart';
import '../rules/happiness_rule.dart';
import '../rules/health_rule.dart';
import '../rules/hunger_rule.dart';

class SimulationEngine {
  final HungerRule hungerRule;
  final EnergyRule energyRule;
  final CleanlinessRule cleanlinessRule;
  final HappinessRule happinessRule;
  final HealthRule healthRule;

  const SimulationEngine({
    required this.hungerRule,
    required this.energyRule,
    required this.cleanlinessRule,
    required this.happinessRule,
    required this.healthRule,
  });

  factory SimulationEngine.standard() {
    return const SimulationEngine(
      hungerRule: HungerRule(),
      energyRule: EnergyRule(),
      cleanlinessRule: CleanlinessRule(),
      happinessRule: HappinessRule(),
      healthRule: HealthRule(),
    );
  }

  Pet applyTimeProgression(Pet pet, int ticks, DateTime now) {
    return pet.copyWith(
      hunger: hungerRule.apply(pet.hunger, ticks),
      energy: energyRule.apply(pet.energy, ticks),
      cleanliness: cleanlinessRule.apply(pet.cleanliness, ticks),
      happiness: happinessRule.apply(pet.happiness, ticks),
      health: healthRule.apply(pet.health, ticks),
      lastUpdatedAt: now,
    );
  }
}
