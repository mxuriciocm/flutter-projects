import 'dart:convert';
import 'dart:io';
import 'package:rick_and_morty/core/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty/features/character/data/remote/character_model.dart';

class CharacterService {
  Future<List<CharacterModel>> getCharacters(int page) async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.character}?page=$page');
    http.Response response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List maps = json['results'];
      return maps.map((map) => CharacterModel.fromJson(map)).toList();
    }
    return [];
  }
}
