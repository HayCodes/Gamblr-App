import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Core
  static const Color black = Color(0xFF0D0D0D);
  static const Color white = Colors.white;
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);


  // Text
  static const Color textPrimary = Color(0xFF0D0D0D);
  static const Color textSecondary = Color(0xFF888888);
  static const Color textHint = Color(0xFFAAAAAA);
  static const Color purpleText = Color(0x800080);

  // Accent
  static const Color green = Color(0xFF2E7D32);
  static const Color greenLight = Color(0xFF43A047);
  static const Color red = Color(0xFFC62828);
  static const Color blue = Color(0xFF1565C0);
  static const Color blueLight = Color(0xFFE3F2FD);

  // Input
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFill = Color(0xFFF8F8F8);

  // Dark (For Splash and Onboarding pages only)
  static const Color darkBg = Color(0xFF0A0A0A);
  static const Color darkOverlay = Color(0xFF1A1A2A);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.dmSans(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.dmSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
