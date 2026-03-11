import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class SimulatorScreen extends StatelessWidget {
  const SimulatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Palestra', style: AppTypography.h1),
              const SizedBox(height: 8),
              Text('Metti in pratica le tue competenze finanziarie', style: AppTypography.bodyMedium),
              const Spacer(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                          begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                      ),
                      child: const Icon(Icons.sports_esports_rounded, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text('Simulatore Finanziario', style: AppTypography.h2),
                    const SizedBox(height: 8),
                    Text(
                      'Simula scenari finanziari reali\ne ricevi un\'analisi post-partita\nstile Chess.com delle tue scelte.',
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text('🎮 In arrivo nella Fase 5',
                          style: AppTypography.labelMedium.copyWith(color: AppColors.warning)),
                    ),
                  ]),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
