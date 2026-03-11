import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class AcademyScreen extends StatelessWidget {
  const AcademyScreen({super.key});

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
              Text('Academy', style: AppTypography.h1),
              const SizedBox(height: 8),
              Text('Il tuo percorso di apprendimento finanziario', style: AppTypography.bodyMedium),
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
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                      ),
                      child: const Icon(Icons.school_rounded, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text('Finny Academy', style: AppTypography.h2),
                    const SizedBox(height: 8),
                    Text(
                      'Il tuo tutor AI personale ti guiderà\nin un percorso gamificato di\neducazione finanziaria.',
                      style: AppTypography.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text('🚀 In arrivo nella Fase 4',
                          style: AppTypography.labelMedium.copyWith(color: AppColors.accent)),
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
