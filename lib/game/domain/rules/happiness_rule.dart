import '../entities/stat.dart';

class HappinessRule {
  Stat apply(Stat happiness, int ticks) {
    return happiness.decrease(ticks);
  }
}
