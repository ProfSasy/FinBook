import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/wallet_provider.dart';
import '../../../data/models/wallet_models.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final currencyFormat = NumberFormat.currency(locale: 'it_IT', symbol: '€');

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        title: const Text('Obiettivi di Risparmio'),
        backgroundColor: AppColors.bgDark,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Aggiungi obiettivo (demo)')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Summary ────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Risparmi totali', style: AppTypography.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          currencyFormat.format(
                            wallet.savingsGoals.fold(0.0, (sum, g) => sum + g.currentAmount),
                          ),
                          style: AppTypography.currencySmall.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: AppColors.border),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Obiettivo totale', style: AppTypography.bodySmall),
                        const SizedBox(height: 4),
                        Text(
                          currencyFormat.format(
                            wallet.savingsGoals.fold(0.0, (sum, g) => sum + g.targetAmount),
                          ),
                          style: AppTypography.currencySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ─── Goals List ──────────────────────────────────
            ...wallet.savingsGoals.map(
              (goal) => _GoalCard(goal: goal, currencyFormat: currencyFormat),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final NumberFormat currencyFormat;

  const _GoalCard({required this.goal, required this.currencyFormat});

  @override
  Widget build(BuildContext context) {
    final isCompleted = goal.progress >= 1.0;
    final percentText = '${(goal.progress * 100).toInt()}%';
    final dateFormat = DateFormat('MMM yyyy', 'it_IT');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: isCompleted ? AppColors.success.withOpacity(0.4) : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(goal.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(goal.title, style: AppTypography.h3),
                        if (isCompleted) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                            ),
                            child: Text(
                              '✓ Completato',
                              style: AppTypography.caption.copyWith(color: AppColors.success, fontSize: 10),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (goal.deadline != null)
                      Text(
                        'Scadenza: ${dateFormat.format(goal.deadline!)}',
                        style: AppTypography.caption,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress Ring
          Row(
            children: [
              SizedBox(
                width: 56,
                height: 56,
                child: CustomPaint(
                  painter: _CircularProgressPainter(
                    progress: goal.progress,
                    activeColor: isCompleted ? AppColors.success : AppColors.primary,
                    bgColor: AppColors.bgCardLight,
                  ),
                  child: Center(
                    child: Text(
                      percentText,
                      style: AppTypography.labelMedium.copyWith(
                        color: isCompleted ? AppColors.success : AppColors.primary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Risparmiato', style: AppTypography.bodySmall),
                        Text(
                          currencyFormat.format(goal.currentAmount),
                          style: AppTypography.labelLarge.copyWith(
                            color: isCompleted ? AppColors.success : AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Obiettivo', style: AppTypography.bodySmall),
                        Text(
                          currencyFormat.format(goal.targetAmount),
                          style: AppTypography.labelLarge,
                        ),
                      ],
                    ),
                    if (!isCompleted) ...[
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mancano', style: AppTypography.bodySmall),
                          Text(
                            currencyFormat.format(goal.remaining),
                            style: AppTypography.labelLarge.copyWith(color: AppColors.warning),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color bgColor;

  _CircularProgressPainter({
    required this.progress,
    required this.activeColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    final strokeWidth = 5.0;

    // Background circle
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final activePaint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
