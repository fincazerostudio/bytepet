import '../domain/entities/pet.dart';
import '../domain/entities/pet_species.dart';
import '../domain/entities/stat.dart';

class PetSaveModel {
  static Map<String, dynamic> toJson(Pet pet) {
    return {
      'name': pet.name,
      'species': pet.species.name,
      'growthStage': pet.growthStage.name,
      'hunger': pet.hunger.value,
      'happiness': pet.happiness.value,
      'energy': pet.energy.value,
      'health': pet.health.value,
      'cleanliness': pet.cleanliness.value,
      'createdAt': pet.createdAt.toIso8601String(),
      'lastUpdatedAt': pet.lastUpdatedAt.toIso8601String(),
    };
  }

  static Pet fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'] as String,
      species: PetSpecies.values.byName(
        (json['species'] as String?) ?? PetSpecies.cat.name,
      ),
      growthStage: GrowthStage.values.byName(json['growthStage'] as String),
      hunger: Stat(json['hunger'] as int),
      happiness: Stat(json['happiness'] as int),
      energy: Stat(json['energy'] as int),
      health: Stat(json['health'] as int),
      cleanliness: Stat(json['cleanliness'] as int),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
    );
  }
}
