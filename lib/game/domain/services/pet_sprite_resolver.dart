import '../entities/pet_species.dart';

class PetSpriteResolver {
  static String idle(PetSpecies species) {
    switch (species) {
      case PetSpecies.cat:
        return 'assets/pets/cat/idle_01.png';

      case PetSpecies.redPanda:
        return 'assets/pets/red_panda/idle_01.png';

      case PetSpecies.axolotl:
        return 'assets/pets/axolotl/idle_01.png';
    }
  }
}
