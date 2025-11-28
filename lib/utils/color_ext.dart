import 'package:flutter/material.dart';

/// Compatibility extension for Color opacity operations.
///
/// The Flutter SDK deprecated `Color.withOpacity` in favor of APIs that avoid
/// precision loss. This small helper provides a drop-in replacement that keeps
/// the same visual behavior by recomputing an ARGB color using the color's
/// integer channels.
extension ColorExt on Color {
  /// Returns a copy of this color with the given opacity.
  ///
  /// `opacity` must be between 0.0 and 1.0.
  Color withOpacityCompat(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
  final int v = toARGB32();
    final int r = (v >> 16) & 0xFF;
    final int g = (v >> 8) & 0xFF;
    final int b = v & 0xFF;
    return Color.fromARGB((opacity * 255).round(), r, g, b);
  }
}
