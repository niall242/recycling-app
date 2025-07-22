// Stores all the colours for normal mode and high contrast mode

import 'package:flutter/material.dart';

class AppColors {
  // Regular theme
  static const Color mainTitle = Color(0xFF63FF63);
  static const Color mainTitleAlt = Color(0xFF47D647);
  static const Color location = Color(0xFF63DDFF);
  static const Color locationIcon = Color(0xFF159BC0);
  static const Color district = Color(0xFFFFE563);
  static const Color districtIcon = Color(0xFFB89900);
  static const Color material = Color(0xFFFFC363);
  static const Color materialIcon = Color(0xFFD08D21);
  static const Color picture = Color(0xFFC288FF);
  static const Color pictureIcon = Color(0xFF9C40FF);
  static const Color settings = Color(0xFFD9D9D9);
  static const Color informationWrong = Color(0xFFFF6363);
}

class AppColorsHighContrast {
  // High Contrast Theme. The goal is to ensure strong foreground/background separation, ideal for 
  //accessibility needs such as visual impairments or color blindness. Retained the same color identity 
  //but amplified contrast:
  static const Color mainTitle = Color(0xFF008000);         // Darker green for strong contrast
  static const Color mainTitleAlt = Color(0xFF005C00);      // Even darker green
  static const Color location = Color(0xFF0077B6);          // Strong blue
  static const Color locationIcon = Color(0xFF003B70);      // Very dark blue
  static const Color district = Color(0xFFFFC800);          // Strong yellow
  static const Color districtIcon = Color(0xFF8A6A00);      // Dark yellow-brown
  static const Color material = Color(0xFFFF8C00);          // Darker orange
  static const Color materialIcon = Color(0xFF8B4600);      // Deep brown-orange
  static const Color picture = Color(0xFF8A2BE2);           // Vivid purple
  static const Color pictureIcon = Color(0xFF4B0082);       // Deep indigo
  static const Color settings = Color(0xFF444444);          // Dark grey for contrast
  static const Color informationWrong = Color(0xFFB00020);  // Strong red for errors
}
