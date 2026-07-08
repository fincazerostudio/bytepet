import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/pet.dart';
import 'pet_save_model.dart';

class PetRepository {
  static const String _petKey = 'bytepet.current_pet';

  Future<void> savePet(Pet pet) async {
    final prefs = await SharedPreferences.getInstance();
    final json = PetSaveModel.toJson(pet);
    await prefs.setString(_petKey, jsonEncode(json));
  }

  Future<Pet?> loadPet() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPet = prefs.getString(_petKey);

    if (savedPet == null) {
      return null;
    }

    final json = jsonDecode(savedPet) as Map<String, dynamic>;
    return PetSaveModel.fromJson(json);
  }

  Future<void> clearPet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_petKey);
  }
}
