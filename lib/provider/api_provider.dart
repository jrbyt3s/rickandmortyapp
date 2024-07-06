import 'package:flutter/material.dart';
import 'package:rickandmortyapp/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapp/models/episode_model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<Episode> episodes = [];

  Future<void> getCharacters(int page) async {
    // GET:https://rickandmortyapi.com/api/character/?page=19
    final result = await http
        .get(Uri.https(url, '/api/character', {'page': page.toString()}));

    final response = characterResponseFromJson(result.body);
    //print(response.results);
    characters.addAll(response.results!); //can be null
    notifyListeners();
  }

  Future<List<Episode>> getEpisode(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }

    return episodes;
  }
}
