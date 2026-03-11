import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/wallet_provider.dart';
import '../../../data/models/wallet_models.dart';

class SubscriptionsScreen extends ConsumerWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final currencyFormat = NumberFormat.currency(locale: 'it_IT', symbol: '€');
    final totalMonthly = wallet.totalSubscriptionsCost;
    final totalYearly = totalMonthly * 12;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Abbonamenti'),
        backgroundColor: AppColors.bgDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Summary Card ────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Totale Mensile',
                    style: AppTypography.labelMedium.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormat.format(totalMonthly),
                    style: AppTypography.currency.copyWith(color: Colors.white, fontSize: 32),
                  ),
                  const SizedBox(height: 12),
                  Container(height: 1, color: Colors.white.withOpacity(0.15)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Costo Annuale', style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
                      Text(
                        currencyFormat.format(totalYearly),
                        style: AppTypography.labelLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Abbonamenti attivi', style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
                      Text(
                        '${wallet.subscriptions.where((s) => s.isActive).length}',
                        style: AppTypography.labelLarge.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('I tuoi abbonamenti', style: AppTypography.h3),
            const SizedBox(height: 16),

            // ─── Subscription List ───────────────────────────
            ...wallet.subscriptions.map(
              (sub) => _SubscriptionCard(subscription: sub, currencyFormat: currencyFormat),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final NumberFormat currencyFormat;

  const _SubscriptionCard({
    required this.subscription,
    required this.currencyFormat,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Streaming': return Icons.play_circle_fill_rounded;
      case 'Musica': return Icons.music_note_rounded;
      case 'Telefonia': return Icons.phone_android_rounded;
      case 'Trasporti': return Icons.directions_subway_rounded;
      case 'Sport': return Icons.fitness_center_rounded;
      case 'Shopping': return Icons.shopping_cart_rounded;
      case 'Produttività': return Icons.psychology_rounded;
      case 'Cloud': return Icons.cloud_rounded;
      default: return Icons.receipt_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Streaming': return AppColors.error;
      case 'Musica': return AppColors.success;
      case 'Telefonia': return AppColors.info;
      case 'Trasporti': return AppColors.catTransport;
      case 'Sport': return AppColors.catHealth;
      case 'Shopping': return AppColors.warning;
      case 'Produttività': return AppColors.accent;
      case 'Cloud': return AppColors.catTransport;
      default: return AppColors.catOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM yyyy', 'it_IT');
    final iconColor = _getCategoryColor(subscription.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(_getCategoryIcon(subscription.category), color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subscription.name, style: AppTypography.labelLarge),
                const SizedBox(height: 2),
                Text(
                  '${subscription.category} · Prossimo: ${dateFormat.format(subscription.nextPayment)}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${currencyFormat.format(subscription.monthlyAmount)}/mese',
                style: AppTypography.labelLarge.copyWith(fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                '${currencyFormat.format(subscription.yearlyAmount)}/anno',
                style: AppTypography.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
