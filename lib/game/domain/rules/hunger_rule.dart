import '../entities/stat.dart';

class HungerRule {
  Stat apply(Stat hunger, int ticks) {
    return hunger.increase(ticks * 2);
  }
}
