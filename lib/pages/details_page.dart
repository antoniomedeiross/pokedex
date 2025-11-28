import 'package:flutter/material.dart';
import 'package:pokedex/utils/color_ext.dart';
import 'package:pokedex/utils/color_type.dart';
import '../models/pokemon.dart';

class DetailsPage extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsPage({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryColor = getColorForType(pokemon.types[0]);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // AppBar 
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor.withOpacityCompat(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Pokébola decorativa
                    Positioned(
                      right: -50,
                      top: 50,
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(
                          Icons.catching_pokemon,
                          size: 200,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    // Imagem 
                    Center(
                      child: Hero(
                        tag: 'pokemon-${pokemon.id}',
                        child: Image.network(
                          pokemon.imageUrl,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    
                    // Número do Pokémon
                    Positioned(
                      top: 60,
                      right: 20,
                      child: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacityCompat(0.3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Conteúdo da página
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome e tipos
                Container(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C2C2C),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Tipos
                      Wrap(
                        spacing: 8,
                        children: pokemon.types.map((type) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: getColorForType(type),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              type,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                
                // Cards de informação
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _buildInfoCard(
                        'Sobre',
                        [
                          _buildInfoRow('Número', '#${pokemon.id.toString().padLeft(3, '0')}'),
                          _buildInfoRow('Nome', pokemon.name),
                          _buildInfoRow(
                            'Tipo${pokemon.types.length > 1 ? 's' : ''}',
                            pokemon.types.join(', '),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 16),
                      
                      _buildInfoCard(
                        'Estatísticas Base',
                        [
                          _buildStatBar('HP', pokemon.stats['hp'] ?? 0, Colors.red),
                          _buildStatBar('Attack', pokemon.stats['attack'] ?? 0, Colors.orange),
                          _buildStatBar('Defense', pokemon.stats['defense'] ?? 0, Colors.yellow),
                          _buildStatBar('Sp. Atk', pokemon.stats['special-attack'] ?? 0, Colors.blue),
                          _buildStatBar('Sp. Def', pokemon.stats['special-defense'] ?? 0, Colors.green),
                          _buildStatBar('Speed', pokemon.stats['speed'] ?? 0, Colors.purple),
                        ],
                      ),
                      
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C2C2C),
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C2C2C),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatBar(String label, int value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
  
  
}