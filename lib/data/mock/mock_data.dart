import '../models/wallet_models.dart';

/// Realistic Italian market mock data for March 2026
class MockData {
  MockData._();

  // ─── Bank Account ──────────────────────────────────────────
  static const BankAccount primaryAccount = BankAccount(
    id: 'acc_001',
    bankName: 'Intesa Sanpaolo',
    iban: 'IT60 X054 2811 1010 0000 0123 456',
    balance: 3847.52,
    accountType: 'Conto Corrente',
  );

  // ─── Transactions (Marzo 2026) ─────────────────────────────
  static final List<Transaction> transactions = [
    Transaction(id: 't_001', title: 'Stipendio - Accenture Italia', amount: 1850.00, category: TransactionCategory.salary, date: DateTime(2026, 3, 1), isIncome: true),
    Transaction(id: 't_002', title: 'Affitto Bilocale - Milano', amount: 750.00, category: TransactionCategory.rent, date: DateTime(2026, 3, 1)),
    Transaction(id: 't_003', title: 'Esselunga - Spesa settimanale', amount: 87.45, category: TransactionCategory.food, date: DateTime(2026, 3, 2)),
    Transaction(id: 't_004', title: 'Trenitalia - Milano↔Roma', amount: 49.90, category: TransactionCategory.transport, date: DateTime(2026, 3, 3)),
    Transaction(id: 't_005', title: 'Netflix Premium', amount: 17.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 3, 4)),
    Transaction(id: 't_006', title: 'Spotify Family', amount: 16.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 3, 4)),
    Transaction(id: 't_007', title: 'Zara - Giacca invernale', amount: 89.95, category: TransactionCategory.shopping, date: DateTime(2026, 3, 5)),
    Transaction(id: 't_008', title: 'ATM Milano - Abbonamento', amount: 39.00, category: TransactionCategory.transport, date: DateTime(2026, 3, 5)),
    Transaction(id: 't_009', title: 'Conad - Spesa', amount: 42.30, category: TransactionCategory.food, date: DateTime(2026, 3, 6)),
    Transaction(id: 't_010', title: 'Enel Energia - Bolletta luce', amount: 68.50, category: TransactionCategory.bills, date: DateTime(2026, 3, 7)),
    Transaction(id: 't_011', title: 'TIM Mobile', amount: 12.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 3, 7)),
    Transaction(id: 't_012', title: 'Cinema The Space', amount: 11.50, category: TransactionCategory.entertainment, date: DateTime(2026, 3, 8)),
    Transaction(id: 't_013', title: 'Amazon - Cuffie Bluetooth', amount: 34.99, category: TransactionCategory.shopping, date: DateTime(2026, 3, 8)),
    Transaction(id: 't_014', title: 'Glovo - Pizza delivery', amount: 18.90, category: TransactionCategory.food, date: DateTime(2026, 3, 9)),
    Transaction(id: 't_015', title: 'Farmacia San Carlo', amount: 15.80, category: TransactionCategory.health, date: DateTime(2026, 3, 9)),
    Transaction(id: 't_016', title: 'PAC Moneyfarm - Versamento', amount: 150.00, category: TransactionCategory.savings, date: DateTime(2026, 3, 10)),
    Transaction(id: 't_017', title: 'Udemy - Corso Python', amount: 14.99, category: TransactionCategory.education, date: DateTime(2026, 3, 10)),
    Transaction(id: 't_018', title: 'Lidl - Spesa', amount: 35.60, category: TransactionCategory.food, date: DateTime(2026, 3, 10)),
    Transaction(id: 't_019', title: 'Italgas - Bolletta gas', amount: 95.00, category: TransactionCategory.bills, date: DateTime(2026, 3, 11)),
    Transaction(id: 't_020', title: 'Aperitivo Navigli', amount: 12.00, category: TransactionCategory.entertainment, date: DateTime(2026, 3, 11)),
    // Mesi precedenti (Febbraio)
    Transaction(id: 't_021', title: 'Stipendio - Accenture Italia', amount: 1850.00, category: TransactionCategory.salary, date: DateTime(2026, 2, 1), isIncome: true),
    Transaction(id: 't_022', title: 'Affitto Bilocale - Milano', amount: 750.00, category: TransactionCategory.rent, date: DateTime(2026, 2, 1)),
    Transaction(id: 't_023', title: 'Esselunga - Spesa', amount: 92.10, category: TransactionCategory.food, date: DateTime(2026, 2, 3)),
    Transaction(id: 't_024', title: 'Ryanair - Volo Milano→Barcellona', amount: 79.99, category: TransactionCategory.travel, date: DateTime(2026, 2, 7)),
    Transaction(id: 't_025', title: 'Booking.com - Hotel Barcellona', amount: 156.00, category: TransactionCategory.travel, date: DateTime(2026, 2, 7)),
    Transaction(id: 't_026', title: 'Palestra FitActive', amount: 29.90, category: TransactionCategory.health, date: DateTime(2026, 2, 10)),
    Transaction(id: 't_027', title: 'Conad - Spesa settimanale', amount: 55.40, category: TransactionCategory.food, date: DateTime(2026, 2, 12)),
    Transaction(id: 't_028', title: 'Netflix Premium', amount: 17.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 2, 4)),
    Transaction(id: 't_029', title: 'Spotify Family', amount: 16.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 2, 4)),
    Transaction(id: 't_030', title: 'ATM Milano - Abbonamento', amount: 39.00, category: TransactionCategory.transport, date: DateTime(2026, 2, 5)),
    Transaction(id: 't_031', title: 'Enel Energia - Bolletta luce', amount: 72.30, category: TransactionCategory.bills, date: DateTime(2026, 2, 8)),
    Transaction(id: 't_032', title: 'TIM Mobile', amount: 12.99, category: TransactionCategory.subscriptions, date: DateTime(2026, 2, 7)),
    Transaction(id: 't_033', title: 'PAC Moneyfarm - Versamento', amount: 150.00, category: TransactionCategory.savings, date: DateTime(2026, 2, 10)),
    Transaction(id: 't_034', title: 'IKEA - Lampada scrivania', amount: 49.95, category: TransactionCategory.shopping, date: DateTime(2026, 2, 15)),
    Transaction(id: 't_035', title: 'Italgas - Bolletta gas', amount: 110.00, category: TransactionCategory.bills, date: DateTime(2026, 2, 12)),
  ];

  // ─── Subscriptions ─────────────────────────────────────────
  static final List<Subscription> subscriptions = [
    Subscription(id: 's_001', name: 'Netflix Premium', monthlyAmount: 17.99, category: 'Streaming', nextPayment: DateTime(2026, 4, 4)),
    Subscription(id: 's_002', name: 'Spotify Family', monthlyAmount: 16.99, category: 'Musica', nextPayment: DateTime(2026, 4, 4)),
    Subscription(id: 's_003', name: 'TIM Mobile', monthlyAmount: 12.99, category: 'Telefonia', nextPayment: DateTime(2026, 4, 7)),
    Subscription(id: 's_004', name: 'ATM Milano', monthlyAmount: 39.00, category: 'Trasporti', nextPayment: DateTime(2026, 4, 5)),
    Subscription(id: 's_005', name: 'FitActive Palestra', monthlyAmount: 29.90, category: 'Sport', nextPayment: DateTime(2026, 4, 10)),
    Subscription(id: 's_006', name: 'Amazon Prime', monthlyAmount: 4.99, category: 'Shopping', nextPayment: DateTime(2026, 4, 15)),
    Subscription(id: 's_007', name: 'ChatGPT Plus', monthlyAmount: 20.00, category: 'Produttività', nextPayment: DateTime(2026, 4, 12)),
    Subscription(id: 's_008', name: 'iCloud+ 200GB', monthlyAmount: 2.99, category: 'Cloud', nextPayment: DateTime(2026, 4, 18)),
  ];

  // ─── Savings Goals ─────────────────────────────────────────
  static final List<SavingsGoal> savingsGoals = [
    SavingsGoal(id: 'g_001', title: 'Fondo Emergenza', emoji: '🛟', targetAmount: 5000.00, currentAmount: 2340.00, deadline: DateTime(2026, 12, 31), createdAt: DateTime(2025, 6, 1)),
    SavingsGoal(id: 'g_002', title: 'Vacanza Giappone', emoji: '🗻', targetAmount: 3000.00, currentAmount: 1150.00, deadline: DateTime(2026, 9, 1), createdAt: DateTime(2025, 9, 1)),
    SavingsGoal(id: 'g_003', title: 'MacBook Pro M4', emoji: '💻', targetAmount: 2499.00, currentAmount: 800.00, deadline: DateTime(2026, 11, 1), createdAt: DateTime(2026, 1, 1)),
    SavingsGoal(id: 'g_004', title: 'Patente di guida', emoji: '🚗', targetAmount: 1200.00, currentAmount: 1200.00, createdAt: DateTime(2025, 3, 1)),
  ];

  // ─── PAC Plans ─────────────────────────────────────────────
  static final List<PacPlan> pacPlans = [
    PacPlan(
      id: 'pac_001',
      name: 'PAC Bilanciato',
      fundName: 'Moneyfarm Portfolio 4',
      monthlyContribution: 150.00,
      totalInvested: 2700.00,
      currentValue: 2892.45,
      startDate: DateTime(2025, 1, 10),
      history: _generatePacHistory(2700, 2892.45, 15),
    ),
    PacPlan(
      id: 'pac_002',
      name: 'PAC Azionario',
      fundName: 'Amundi MSCI World ETF',
      monthlyContribution: 100.00,
      totalInvested: 1200.00,
      currentValue: 1345.80,
      startDate: DateTime(2025, 4, 1),
      history: _generatePacHistory(1200, 1345.80, 12),
    ),
  ];

  static List<PacDataPoint> _generatePacHistory(double start, double end, int months) {
    final List<PacDataPoint> points = [];
    final now = DateTime(2026, 3, 11);
    for (int i = months; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 10);
      final progress = 1.0 - (i / months);
      // Simulate slight variation
      final variance = (i % 3 == 0 ? -0.02 : 0.015) * progress;
      final value = start * (1 - progress) + end * progress + (end * variance);
      points.add(PacDataPoint(date: date, value: value.clamp(0, double.infinity)));
    }
    return points;
  }

  // ─── Monthly Expense Summary ───────────────────────────────
  static const List<MonthlyExpenseSummary> monthlyExpenses = [
    MonthlyExpenseSummary(month: 'Ott', amount: 1420),
    MonthlyExpenseSummary(month: 'Nov', amount: 1580),
    MonthlyExpenseSummary(month: 'Dic', amount: 1890),
    MonthlyExpenseSummary(month: 'Gen', amount: 1350),
    MonthlyExpenseSummary(month: 'Feb', amount: 1640),
    MonthlyExpenseSummary(month: 'Mar', amount: 1530),
  ];

  // ─── Total Expense by Category (current month) ────────────
  static const Map<TransactionCategory, double> categoryExpenses = {
    TransactionCategory.rent: 750.00,
    TransactionCategory.food: 184.25,
    TransactionCategory.bills: 163.50,
    TransactionCategory.savings: 150.00,
    TransactionCategory.shopping: 124.94,
    TransactionCategory.transport: 88.90,
    TransactionCategory.subscriptions: 47.97,
    TransactionCategory.entertainment: 23.50,
    TransactionCategory.health: 15.80,
    TransactionCategory.education: 14.99,
  };
}
