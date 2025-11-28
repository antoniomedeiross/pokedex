import 'dart:ui';

Color getColorForType(String type) {
    switch (type) {
      case 'grass':
        return Color(0xFF48D0B0);
      case 'fire':
        return Color(0xFFFF6B6B);
      case 'water':
        return Color(0xFF4A90E2);
      case 'bug':
        return Color(0xFF8BC34A);
      case 'poison':
        return Color(0xFF9B59B6);
      case 'electric':
        return Color(0xFFFFC107);
      case 'ground':
        return Color(0xFFA1887F);
      case 'fairy':
        return Color(0xFFFF9ECD);
      case 'fighting':
        return Color(0xFFE74C3C);
      case 'psychic':
        return Color(0xFFE91E63);
      case 'rock':
        return Color(0xFF795548);
      case 'ghost':
        return Color(0xFF7B68EE);
      case 'ice':
        return Color(0xFF81D4FA);
      case 'dragon':
        return Color(0xFF7C4DFF);
      case 'dark':
        return Color(0xFF5D4037);
      case 'steel':
        return Color(0xFF78909C);
      case 'flying':
        return Color(0xFF9FA8DA);
      case 'normal':
      default:
        return Color(0xFF9E9E9E);
    }
  }