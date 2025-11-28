import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<List<Pokemon>> fetchPokemons({int limit = 10, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl?limit=$limit&offset=$offset'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      // 1. Mapeia a lista de resultados para uma lista de Futures
      final pokemonFutures = results.map((item) {
        return _fetchPokemonDetails(item['url']);
      }).toList();

      // 2. Aguarda todas as requisições em paralelo
      final pokemons = await Future.wait(pokemonFutures);

      return pokemons;
    } else {
      throw Exception('Falha ao carregar a lista de Pokémons');
    }
  }

  // Método auxiliar para buscar e processar os detalhes de um único Pokémon
  Future<Pokemon> _fetchPokemonDetails(String url) async {
    final detailResponse = await http.get(Uri.parse(url));

    if (detailResponse.statusCode == 200) {
      final detailData = jsonDecode(detailResponse.body);

      return Pokemon(
        id: detailData['id'],
        name: detailData['name'],
        imageUrl: detailData['sprites']['other']['official-artwork']
            ['front_default'],
        types: (detailData['types'] as List)
            .map((t) => t['type']['name'] as String)
            .toList(),
        stats: Map.fromEntries(
          (detailData['stats'] as List).map(
            (s) =>
                MapEntry(s['stat']['name'] as String, s['base_stat'] as int),
          ),
        ),
        moves: (detailData['moves'] as List)
            .map((m) => m['move']['name'] as String)
            .toList(),
      );
    } else {
      throw Exception('Falha ao carregar detalhes do Pokémon: $url');
    }
  }
}
