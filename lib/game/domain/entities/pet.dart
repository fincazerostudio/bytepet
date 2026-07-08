import 'stat.dart';

enum GrowthStage {
  baby,
  child,
  teen,
  adult,
}

class Pet {
  final String name;
  final GrowthStage growthStage;

  final Stat hunger;
  final Stat happiness;
  final Stat energy;
  final Stat health;
  final Stat cleanliness;

  final DateTime createdAt;
  final DateTime lastUpdatedAt;

  const Pet({
    required this.name,
    required this.growthStage,
    required this.hunger,
    required this.happiness,
    required this.energy,
    required this.health,
    required this.cleanliness,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  Pet copyWith({
    String? name,
    GrowthStage? growthStage,
    Stat? hunger,
    Stat? happiness,
    Stat? energy,
    Stat? health,
    Stat? cleanliness,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) {
    return Pet(
      name: name ?? this.name,
      growthStage: growthStage ?? this.growthStage,
      hunger: hunger ?? this.hunger,
      happiness: happiness ?? this.happiness,
      energy: energy ?? this.energy,
      health: health ?? this.health,
      cleanliness: cleanliness ?? this.cleanliness,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }
}
