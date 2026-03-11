import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
              const Spacer(),
              // Logo / Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 40,
                  color: AppColors.textOnPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Come vuoi gestire\nle tue finanze?',
                style: AppTypography.displayLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Scegli come importare i tuoi dati finanziari. Potrai sempre cambiare in seguito.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 40),
              // Option 1: Bank Connect
              _OnboardingOption(
                icon: Icons.link_rounded,
                title: 'Collega la tua banca',
                description: 'Sincronizzazione automatica in SOLA LETTURA. Non possiamo fare operazioni sul tuo conto.',
                badge: '🔒 Privacy garantita',
                gradient: AppColors.primaryGradient,
                onTap: () {
                  // TODO: Navigate to bank connection flow
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Collegamento bancario (demo) — funzionalità in sviluppo')),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Option 2: Manual Entry
              _OnboardingOption(
                icon: Icons.edit_note_rounded,
                title: 'Inserisci manualmente',
                description: 'Aggiungi le tue transazioni a mano. Controllo totale sui tuoi dati.',
                badge: '✍️ Full control',
                gradient: AppColors.accentGradient,
                onTap: () {
                  // TODO: Navigate to manual entry
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Inserimento manuale (demo) — funzionalità in sviluppo')),
                  );
                },
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String badge;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _OnboardingOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.badge,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(icon, size: 26, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.h3),
                  const SizedBox(height: 4),
                  Text(description, style: AppTypography.bodySmall, maxLines: 2),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.bgCardLight,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(badge, style: AppTypography.caption.copyWith(fontSize: 10)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
