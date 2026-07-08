class Stat {
  static const int min = 0;
  static const int max = 100;

  final int value;

  const Stat._(this.value);

  factory Stat(int value) {
    return Stat._(value.clamp(min, max));
  }

  Stat increase(int amount) {
    return Stat(value + amount);
  }

  Stat decrease(int amount) {
    return Stat(value - amount);
  }
}
