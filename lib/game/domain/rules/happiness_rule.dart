import '../entities/stat.dart';

class HappinessRule {
  const HappinessRule();

  Stat apply(Stat happiness, int ticks) {
    return happiness.decrease(ticks);
  }
}
