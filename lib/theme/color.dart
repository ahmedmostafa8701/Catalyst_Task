import 'dart:ui';

import 'package:flutter/material.dart';

var colorScheme = const ColorScheme(
  primary: Color(0xFF3772FF), // Bright Blue
  onPrimary: Color(0xFFE6E8E6), // Light Gray for text/icons on primary
  secondary: Color(0xFFFDCA40), // Golden Yellow
  onSecondary: Color(0xFF080708), // Almost Black for text/icons on secondary
  background: Color(0xFFFFFFFF), // Light Gray for app background
  onBackground: Color(0xFF080708), // Almost Black for text/icons on background
  surface: Color(0xFFE6E8E6), // Light Gray for elevated surfaces (same as background)
  onSurface: Color(0xFF080708), // Almost Black for text/icons on surface
  error: Color(0xFFDF2935), // Bright Red for errors
  onError: Color(0xFFE6E8E6), // Light Gray for text/icons on error background
  brightness: Brightness.light, // Adjust if you want a dark theme
);