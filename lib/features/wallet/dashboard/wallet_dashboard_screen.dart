import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/wallet_provider.dart';
import '../../../data/models/wallet_models.dart';

class WalletDashboardScreen extends ConsumerWidget {
  const WalletDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final currencyFormat = NumberFormat.currency(locale: 'it_IT', symbol: '€');

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ─── App Bar ─────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Buongiorno 👋', style: AppTypography.bodyMedium),
                        const SizedBox(height: 2),
                        Text('Il tuo Wallet', style: AppTypography.h1),
                      ],
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: const Center(
                        child: Text('FB', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textOnPrimary)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ─── Balance Card ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _BalanceCard(
                  balance: wallet.account.balance,
                  totalExpenses: wallet.totalExpensesThisMonth,
                  bankName: wallet.account.bankName,
                  currencyFormat: currencyFormat,
                ),
              ),
            ),

            // ─── Quick Actions ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    _QuickAction(
                      icon: Icons.subscriptions_rounded,
                      label: 'Abbonamenti',
                      color: AppColors.accent,
                      onTap: () => context.go('/wallet/subscriptions'),
                    ),
                    const SizedBox(width: 12),
                    _QuickAction(
                      icon: Icons.flag_rounded,
                      label: 'Obiettivi',
                      color: AppColors.success,
                      onTap: () => context.go('/wallet/goals'),
                    ),
                    const SizedBox(width: 12),
                    _QuickAction(
                      icon: Icons.trending_up_rounded,
                      label: 'PAC',
                      color: AppColors.primaryLight,
                      onTap: () => context.go('/wallet/pac'),
                    ),
                  ],
                ),
              ),
            ),

            // ─── Expense Chart ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _ExpenseChart(monthlyExpenses: wallet.monthlyExpenses),
              ),
            ),

            // ─── Category Breakdown ──────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _CategoryBreakdown(
                  categoryExpenses: wallet.categoryExpenses,
                  currencyFormat: currencyFormat,
                ),
              ),
            ),

            // ─── Recent Transactions Header ──────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transazioni recenti', style: AppTypography.h3),
                    Text('Vedi tutte', style: AppTypography.bodyMedium.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
            ),

            // ─── Transaction List ────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final tx = wallet.currentMonthTransactions[index];
                  return _TransactionTile(
                    transaction: tx,
                    currencyFormat: currencyFormat,
                  );
                },
                childCount: wallet.currentMonthTransactions.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ─── Balance Card Widget ───────────────────────────────────────
class _BalanceCard extends StatelessWidget {
  final double balance;
  final double totalExpenses;
  final String bankName;
  final NumberFormat currencyFormat;

  const _BalanceCard({
    required this.balance,
    required this.totalExpenses,
    required this.bankName,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.balanceGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saldo disponibile',
                style: AppTypography.labelMedium.copyWith(
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  bankName,
                  style: AppTypography.caption.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            currencyFormat.format(balance),
            style: AppTypography.currency.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _BalanceStat(
                label: 'Entrate',
                value: currencyFormat.format(1850.00),
                icon: Icons.arrow_downward_rounded,
                iconColor: Colors.white,
              ),
              const SizedBox(width: 24),
              _BalanceStat(
                label: 'Spese (Mar)',
                value: currencyFormat.format(totalExpenses),
                icon: Icons.arrow_upward_rounded,
                iconColor: Colors.white.withOpacity(0.7),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _BalanceStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.caption.copyWith(color: Colors.white.withOpacity(0.7))),
            Text(value, style: AppTypography.labelLarge.copyWith(color: Colors.white, fontSize: 13)),
          ],
        ),
      ],
    );
  }
}

// ─── Quick Action Button ───────────────────────────────────────
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 8),
              Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Monthly Expense Chart ─────────────────────────────────────
class _ExpenseChart extends StatelessWidget {
  final List<MonthlyExpenseSummary> monthlyExpenses;

  const _ExpenseChart({required this.monthlyExpenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spese Mensili', style: AppTypography.h3),
          const SizedBox(height: 4),
          Text('Ultimi 6 mesi', style: AppTypography.bodySmall),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 2200,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => AppColors.bgCardLight,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '€${rod.toY.toInt()}',
                        AppTypography.labelMedium.copyWith(color: AppColors.primary),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx >= 0 && idx < monthlyExpenses.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              monthlyExpenses[idx].month,
                              style: AppTypography.caption,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 500,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border,
                      strokeWidth: 0.5,
                      dashArray: [5, 5],
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  monthlyExpenses.length,
                  (index) {
                    final isLast = index == monthlyExpenses.length - 1;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: monthlyExpenses[index].amount,
                          gradient: isLast ? AppColors.primaryGradient : null,
                          color: isLast ? null : AppColors.bgCardLight,
                          width: 28,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Category Breakdown ────────────────────────────────────────
class _CategoryBreakdown extends StatelessWidget {
  final Map<TransactionCategory, double> categoryExpenses;
  final NumberFormat currencyFormat;

  const _CategoryBreakdown({
    required this.categoryExpenses,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final sortedEntries = categoryExpenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = categoryExpenses.values.fold(0.0, (sum, v) => sum + v);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spese per Categoria', style: AppTypography.h3),
          const SizedBox(height: 4),
          Text('Marzo 2026', style: AppTypography.bodySmall),
          const SizedBox(height: 16),
          ...sortedEntries.take(5).map((entry) {
            final percent = (entry.value / total * 100);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: entry.key.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(entry.key.icon, color: entry.key.color, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(entry.key.label, style: AppTypography.labelLarge.copyWith(fontSize: 13)),
                            Text(currencyFormat.format(entry.value), style: AppTypography.labelLarge.copyWith(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: percent / 100,
                            backgroundColor: AppColors.bgCardLight,
                            valueColor: AlwaysStoppedAnimation(entry.key.color),
                            minHeight: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Transaction Tile ──────────────────────────────────────────
class _TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final NumberFormat currencyFormat;

  const _TransactionTile({
    required this.transaction,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('d MMM', 'it_IT');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: transaction.category.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                transaction.category.icon,
                color: transaction.category.color,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: AppTypography.labelLarge.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${transaction.category.label} · ${dateFormat.format(transaction.date)}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            Text(
              '${transaction.isIncome ? '+' : '-'}${currencyFormat.format(transaction.amount)}',
              style: AppTypography.labelLarge.copyWith(
                fontSize: 14,
                color: transaction.isIncome ? AppColors.success : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
