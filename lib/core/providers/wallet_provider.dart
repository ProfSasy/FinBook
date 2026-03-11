import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/wallet_models.dart';
import '../../data/mock/mock_data.dart';

/// Wallet state — manages all financial data
class WalletState {
  final BankAccount account;
  final List<Transaction> transactions;
  final List<Subscription> subscriptions;
  final List<SavingsGoal> savingsGoals;
  final List<PacPlan> pacPlans;
  final List<MonthlyExpenseSummary> monthlyExpenses;
  final Map<TransactionCategory, double> categoryExpenses;
  final bool isOnboarded;

  const WalletState({
    required this.account,
    required this.transactions,
    required this.subscriptions,
    required this.savingsGoals,
    required this.pacPlans,
    required this.monthlyExpenses,
    required this.categoryExpenses,
    this.isOnboarded = false,
  });

  WalletState copyWith({
    BankAccount? account,
    List<Transaction>? transactions,
    List<Subscription>? subscriptions,
    List<SavingsGoal>? savingsGoals,
    List<PacPlan>? pacPlans,
    List<MonthlyExpenseSummary>? monthlyExpenses,
    Map<TransactionCategory, double>? categoryExpenses,
    bool? isOnboarded,
  }) {
    return WalletState(
      account: account ?? this.account,
      transactions: transactions ?? this.transactions,
      subscriptions: subscriptions ?? this.subscriptions,
      savingsGoals: savingsGoals ?? this.savingsGoals,
      pacPlans: pacPlans ?? this.pacPlans,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      categoryExpenses: categoryExpenses ?? this.categoryExpenses,
      isOnboarded: isOnboarded ?? this.isOnboarded,
    );
  }

  double get totalSubscriptionsCost =>
      subscriptions.where((s) => s.isActive).fold(0.0, (sum, s) => sum + s.monthlyAmount);

  double get totalExpensesThisMonth =>
      categoryExpenses.values.fold(0.0, (sum, v) => sum + v);

  List<Transaction> get recentTransactions {
    final sorted = List<Transaction>.from(transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(10).toList();
  }

  List<Transaction> get currentMonthTransactions {
    final now = DateTime(2026, 3, 11);
    return transactions
        .where((t) => t.date.month == now.month && t.date.year == now.year)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
}

class WalletNotifier extends Notifier<WalletState> {
  @override
  WalletState build() {
    return WalletState(
      account: MockData.primaryAccount,
      transactions: MockData.transactions,
      subscriptions: MockData.subscriptions,
      savingsGoals: MockData.savingsGoals,
      pacPlans: MockData.pacPlans,
      monthlyExpenses: MockData.monthlyExpenses,
      categoryExpenses: MockData.categoryExpenses,
      isOnboarded: true,
    );
  }

  void completeOnboarding() {
    state = state.copyWith(isOnboarded: true);
  }

  void addTransaction(Transaction transaction) {
    state = state.copyWith(transactions: [...state.transactions, transaction]);
  }

  void addSavingsGoal(SavingsGoal goal) {
    state = state.copyWith(savingsGoals: [...state.savingsGoals, goal]);
  }
}

final walletProvider = NotifierProvider<WalletNotifier, WalletState>(WalletNotifier.new);
