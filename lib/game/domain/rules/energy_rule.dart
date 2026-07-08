import '../entities/stat.dart';

class EnergyRule {
  Stat apply(Stat energy, int ticks) {
    return energy.decrease(ticks);
  }
}
