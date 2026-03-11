import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Transaction categories for the Wallet
enum TransactionCategory {
  salary,
  food,
  transport,
  entertainment,
  shopping,
  health,
  bills,
  savings,
  rent,
  education,
  travel,
  subscriptions,
  other,
}

extension TransactionCategoryExt on TransactionCategory {
  String get label {
    switch (this) {
      case TransactionCategory.salary: return 'Stipendio';
      case TransactionCategory.food: return 'Alimentari';
      case TransactionCategory.transport: return 'Trasporti';
      case TransactionCategory.entertainment: return 'Svago';
      case TransactionCategory.shopping: return 'Shopping';
      case TransactionCategory.health: return 'Salute';
      case TransactionCategory.bills: return 'Bollette';
      case TransactionCategory.savings: return 'Risparmi';
      case TransactionCategory.rent: return 'Affitto';
      case TransactionCategory.education: return 'Formazione';
      case TransactionCategory.travel: return 'Viaggi';
      case TransactionCategory.subscriptions: return 'Abbonamenti';
      case TransactionCategory.other: return 'Altro';
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionCategory.salary: return Icons.account_balance_wallet;
      case TransactionCategory.food: return Icons.restaurant;
      case TransactionCategory.transport: return Icons.directions_car;
      case TransactionCategory.entertainment: return Icons.movie;
      case TransactionCategory.shopping: return Icons.shopping_bag;
      case TransactionCategory.health: return Icons.health_and_safety;
      case TransactionCategory.bills: return Icons.receipt_long;
      case TransactionCategory.savings: return Icons.savings;
      case TransactionCategory.rent: return Icons.home;
      case TransactionCategory.education: return Icons.school;
      case TransactionCategory.travel: return Icons.flight;
      case TransactionCategory.subscriptions: return Icons.subscriptions;
      case TransactionCategory.other: return Icons.more_horiz;
    }
  }

  Color get color {
    switch (this) {
      case TransactionCategory.salary: return AppColors.success;
      case TransactionCategory.food: return AppColors.catFood;
      case TransactionCategory.transport: return AppColors.catTransport;
      case TransactionCategory.entertainment: return AppColors.catEntertainment;
      case TransactionCategory.shopping: return AppColors.catShopping;
      case TransactionCategory.health: return AppColors.catHealth;
      case TransactionCategory.bills: return AppColors.catBills;
      case TransactionCategory.savings: return AppColors.catSavings;
      case TransactionCategory.rent: return AppColors.warning;
      case TransactionCategory.education: return AppColors.info;
      case TransactionCategory.travel: return AppColors.accent;
      case TransactionCategory.subscriptions: return AppColors.accentLight;
      case TransactionCategory.other: return AppColors.catOther;
    }
  }
}

class Transaction {
  final String id;
  final String title;
  final String? description;
  final double amount;
  final TransactionCategory category;
  final DateTime date;
  final bool isIncome;
  final String? merchantLogo;

  const Transaction({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.category,
    required this.date,
    this.isIncome = false,
    this.merchantLogo,
  });
}

class BankAccount {
  final String id;
  final String bankName;
  final String iban;
  final double balance;
  final String accountType;

  const BankAccount({
    required this.id,
    required this.bankName,
    required this.iban,
    required this.balance,
    required this.accountType,
  });
}

class Subscription {
  final String id;
  final String name;
  final double monthlyAmount;
  final String category;
  final DateTime nextPayment;
  final String? logoUrl;
  final bool isActive;

  const Subscription({
    required this.id,
    required this.name,
    required this.monthlyAmount,
    required this.category,
    required this.nextPayment,
    this.logoUrl,
    this.isActive = true,
  });

  double get yearlyAmount => monthlyAmount * 12;
}

class SavingsGoal {
  final String id;
  final String title;
  final String emoji;
  final double targetAmount;
  final double currentAmount;
  final DateTime? deadline;
  final DateTime createdAt;

  const SavingsGoal({
    required this.id,
    required this.title,
    required this.emoji,
    required this.targetAmount,
    required this.currentAmount,
    this.deadline,
    required this.createdAt,
  });

  double get progress => (currentAmount / targetAmount).clamp(0.0, 1.0);
  double get remaining => targetAmount - currentAmount;
}

class PacPlan {
  final String id;
  final String name;
  final String fundName;
  final double monthlyContribution;
  final double totalInvested;
  final double currentValue;
  final DateTime startDate;
  final List<PacDataPoint> history;

  const PacPlan({
    required this.id,
    required this.name,
    required this.fundName,
    required this.monthlyContribution,
    required this.totalInvested,
    required this.currentValue,
    required this.startDate,
    required this.history,
  });

  double get gainLoss => currentValue - totalInvested;
  double get gainLossPercent => totalInvested > 0 ? (gainLoss / totalInvested) * 100 : 0;
}

class PacDataPoint {
  final DateTime date;
  final double value;

  const PacDataPoint({required this.date, required this.value});
}

class MonthlyExpenseSummary {
  final String month;
  final double amount;

  const MonthlyExpenseSummary({required this.month, required this.amount});
}
