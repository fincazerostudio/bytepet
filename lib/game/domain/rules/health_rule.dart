import '../entities/stat.dart';

class HealthRule {
  const HealthRule();

  Stat apply(Stat health, int ticks) {
    return health;
  }
}
