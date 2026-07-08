import '../entities/stat.dart';

class HealthRule {
  Stat apply(Stat health, int ticks) {
    return health;
  }
}
