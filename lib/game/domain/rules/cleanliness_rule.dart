import '../entities/stat.dart';

class CleanlinessRule {
  const CleanlinessRule();

  Stat apply(Stat cleanliness, int ticks) {
    return cleanliness.decrease(ticks);
  }
}
