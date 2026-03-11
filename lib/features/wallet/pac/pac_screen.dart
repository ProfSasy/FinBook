import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/wallet_provider.dart';
import '../../../data/models/wallet_models.dart';

class PacScreen extends ConsumerWidget {
  const PacScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wallet = ref.watch(walletProvider);
    final fmt = NumberFormat.currency(locale: 'it_IT', symbol: '€');
    final totalInvested = wallet.pacPlans.fold(0.0, (s, p) => s + p.totalInvested);
    final totalValue = wallet.pacPlans.fold(0.0, (s, p) => s + p.currentValue);
    final gain = totalValue - totalInvested;
    final gainPct = totalInvested > 0 ? (gain / totalInvested * 100) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(title: const Text('Piani di Accumulo'), backgroundColor: AppColors.bgDark),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _SummaryCard(totalValue: totalValue, totalInvested: totalInvested, gain: gain, gainPct: gainPct, fmt: fmt),
          const SizedBox(height: 24),
          ...wallet.pacPlans.map((pac) => _PacCard(pac: pac, fmt: fmt)),
        ]),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double totalValue, totalInvested, gain, gainPct;
  final NumberFormat fmt;
  const _SummaryCard({required this.totalValue, required this.totalInvested, required this.gain, required this.gainPct, required this.fmt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Valore Totale PAC', style: AppTypography.labelMedium.copyWith(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(fmt.format(totalValue), style: AppTypography.currency.copyWith(color: Colors.white, fontSize: 30)),
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.white.withOpacity(0.15)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Investito', style: AppTypography.caption.copyWith(color: Colors.white70)),
            Text(fmt.format(totalInvested), style: AppTypography.labelLarge.copyWith(color: Colors.white)),
          ])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rendimento', style: AppTypography.caption.copyWith(color: Colors.white70)),
            Text('${gain >= 0 ? '+' : ''}${fmt.format(gain)} (${gainPct.toStringAsFixed(1)}%)',
                style: AppTypography.labelLarge.copyWith(color: Colors.white)),
          ])),
        ]),
      ]),
    );
  }
}

class _PacCard extends StatelessWidget {
  final PacPlan pac;
  final NumberFormat fmt;
  const _PacCard({required this.pac, required this.fmt});

  @override
  Widget build(BuildContext context) {
    final isPositive = pac.gainLoss >= 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(AppSpacing.radiusLg), border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 44, height: 44,
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: const Icon(Icons.trending_up_rounded, color: AppColors.primary, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(pac.name, style: AppTypography.h3), Text(pac.fundName, style: AppTypography.caption)])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(fmt.format(pac.currentValue), style: AppTypography.labelLarge),
            Text('${isPositive ? '+' : ''}${pac.gainLossPercent.toStringAsFixed(1)}%',
                style: AppTypography.labelMedium.copyWith(color: isPositive ? AppColors.success : AppColors.error)),
          ]),
        ]),
        const SizedBox(height: 16),
        SizedBox(height: 140, child: LineChart(LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false, horizontalInterval: 500,
            getDrawingHorizontalLine: (v) => FlLine(color: AppColors.border, strokeWidth: 0.5, dashArray: [5, 5])),
          titlesData: FlTitlesData(show: true,
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 24,
              interval: (pac.history.length / 4).ceilToDouble(),
              getTitlesWidget: (v, m) {
                final i = v.toInt();
                if (i >= 0 && i < pac.history.length) {
                  return Text(DateFormat('MMM', 'it_IT').format(pac.history[i].date), style: AppTypography.caption);
                }
                return const SizedBox.shrink();
              })),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))),
          borderData: FlBorderData(show: false),
          lineBarsData: [LineChartBarData(
            spots: List.generate(pac.history.length, (i) => FlSpot(i.toDouble(), pac.history[i].value)),
            isCurved: true, color: AppColors.primary, barWidth: 2.5, isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: true, gradient: LinearGradient(
              colors: [AppColors.primary.withOpacity(0.2), AppColors.primary.withOpacity(0.0)],
              begin: Alignment.topCenter, end: Alignment.bottomCenter)))],
          lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (s) => AppColors.bgCardLight,
            getTooltipItems: (spots) => spots.map((s) => LineTooltipItem(
              '€${s.y.toStringAsFixed(0)}', AppTypography.labelMedium.copyWith(color: AppColors.primary))).toList())),
        ))),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Versamento', style: AppTypography.caption),
            Text('${fmt.format(pac.monthlyContribution)}/mese', style: AppTypography.labelMedium.copyWith(fontSize: 11))])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Investito', style: AppTypography.caption),
            Text(fmt.format(pac.totalInvested), style: AppTypography.labelMedium.copyWith(fontSize: 11))])),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Attivo da', style: AppTypography.caption),
            Text(DateFormat('MMM yyyy', 'it_IT').format(pac.startDate), style: AppTypography.labelMedium.copyWith(fontSize: 11))])),
        ]),
      ]),
    );
  }
}
