import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_card.dart';
import '../utils/color_ext.dart';
import '../services/poke_api_service.dart'; // <-- IMPORTANTE

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokeApiService api = PokeApiService();

  int currentPage = 0;
  final int itemsPerPage = 10;

  late Future<List<Pokemon>> futurePokemons;

  @override
  void initState() {
    super.initState();
    futurePokemons = api.fetchPokemons(
      limit: itemsPerPage,
      offset: currentPage * itemsPerPage,
    );
  }

  void _loadPage(int page) {
    setState(() {
      currentPage = page;
      futurePokemons = api.fetchPokemons(
        limit: itemsPerPage,
        offset: currentPage * itemsPerPage,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 6;
    } else if (screenWidth > 900) {
      crossAxisCount = 5;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 86, 157, 255),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: const Text(
                'Pokédex',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 87, 87),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade200,
                      width: 1,
                    ),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Icon(
                      Icons.catching_pokemon,
                      size: 100,
                      color:
                          const Color.fromARGB(255, 188, 183, 182).withOpacityCompat(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // CONTEÚDO
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: FutureBuilder<List<Pokemon>>(
                    future: futurePokemons,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text(
                          'Erro ao carregar pokémons',
                          style: TextStyle(color: Colors.red.shade700),
                        );
                      }

                      final pokemons = snapshot.data ?? [];

                      return Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: pokemons.length,
                            itemBuilder: (context, index) {
                              return PokemonCard(pokemon: pokemons[index]);
                            },
                          ),

                          const SizedBox(height: 16),

                          // PAGINAÇÃO
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: currentPage > 0
                                    ? () => _loadPage(currentPage - 1)
                                    : null,
                                child: const Text('Página anterior'),
                              ),
                              const SizedBox(width: 16),
                              Text("Página ${currentPage + 1}"),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: pokemons.length == itemsPerPage
                                    ? () => _loadPage(currentPage + 1)
                                    : null,
                                child: const Text('Próxima página'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _loadPage(currentPage),
        backgroundColor: const Color(0xFFE74C3C),
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
