import 'package:flutter/material.dart';
import 'package:pokedex/utils/color_type.dart';
import '../models/pokemon.dart';
import '../pages/details_page.dart';
import '../utils/color_ext.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryColor = getColorForType(pokemon.types[0]);
  final secondaryColor = pokemon.types.length > 1 
    ? getColorForType(pokemon.types[1])
    : primaryColor.withOpacityCompat(0.7);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(pokemon: pokemon),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, secondaryColor],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacityCompat(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Padrão de fundo decorativo
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  Icons.catching_pokemon,
                  size: 300,
                  color: Colors.white.withOpacityCompat(0.1),
                ),
              ),
              
              // Conteúdo do card
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Número do Pokémon
                    Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        color: Colors.white.withOpacityCompat(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Imagem do Pokémon
                    Center(
                      child: Hero(
                        tag: 'pokemon-${pokemon.id}',
                        child: Image.network(
                          pokemon.imageUrl,
                          height: 140,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Nome do Pokémon
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    SizedBox(height: 4),
                    
                    // Tipos do Pokémon
                    Wrap(
                      spacing: 4,
                      children: pokemon.types.map((type) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacityCompat(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            type,
                            style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}