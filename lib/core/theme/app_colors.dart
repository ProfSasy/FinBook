import 'package:flutter/material.dart';

/// FinBook Design System — Color Palette
/// Dark-mode premium FinTech aesthetic with teal/emerald accents
class AppColors {
  AppColors._();

  // ─── Primary Brand ──────────────────────────────────────────
  static const Color primary = Color(0xFF0ED3A3); // Emerald/Teal
  static const Color primaryLight = Color(0xFF5DFFCF);
  static const Color primaryDark = Color(0xFF00A876);

  // ─── Accent ─────────────────────────────────────────────────
  static const Color accent = Color(0xFF6C63FF); // Indigo/Violet
  static const Color accentLight = Color(0xFFA29BFF);
  static const Color accentDark = Color(0xFF4A42CC);

  // ─── Status Colors ──────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ─── Blunder/Move Analysis Colors (Chess.com style) ─────────
  static const Color blunder = Color(0xFFEF4444);    // 🔴 Errore Grave
  static const Color mistake = Color(0xFFF97316);     // 🟠 Imprecisione
  static const Color good = Color(0xFF22C55E);        // 🟢 Buona Scelta
  static const Color excellent = Color(0xFFFFD700);   // 🌟 Mossa Eccellente

  // ─── Dark Theme Background ─────────────────────────────────
  static const Color bgDark = Color(0xFF0A0E14);
  static const Color bgCard = Color(0xFF141B24);
  static const Color bgCardLight = Color(0xFF1C2630);
  static const Color bgSurface = Color(0xFF111820);
  static const Color bgBottomNav = Color(0xFF0F1319);

  // ─── Text ───────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textOnPrimary = Color(0xFF0A0E14);

  // ─── Borders & Dividers ─────────────────────────────────────
  static const Color border = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFF334155);
  static const Color divider = Color(0xFF1E293B);

  // ─── Category Colors (for expense charts) ───────────────────
  static const Color catFood = Color(0xFFFB923C);
  static const Color catTransport = Color(0xFF38BDF8);
  static const Color catEntertainment = Color(0xFFA78BFA);
  static const Color catShopping = Color(0xFFFB7185);
  static const Color catHealth = Color(0xFF4ADE80);
  static const Color catBills = Color(0xFF818CF8);
  static const Color catSavings = Color(0xFF0ED3A3);
  static const Color catOther = Color(0xFF94A3B8);

  // ─── Gradients ──────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [bgCard, bgCardLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient balanceGradient = LinearGradient(
    colors: [Color(0xFF0ED3A3), Color(0xFF06B6D4), Color(0xFF6C63FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
