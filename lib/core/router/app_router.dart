import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/wallet/dashboard/wallet_dashboard_screen.dart';
import '../../features/wallet/subscriptions/subscriptions_screen.dart';
import '../../features/wallet/goals/goals_screen.dart';
import '../../features/wallet/pac/pac_screen.dart';
import '../../features/wallet/onboarding/onboarding_screen.dart';
import '../../features/academy/academy_screen.dart';
import '../../features/simulator/simulator_screen.dart';
import '../theme/app_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _walletNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'wallet');
final _academyNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'academy');
final _simulatorNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'simulator');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/wallet',
  routes: [
    // ─── Onboarding (full screen, no bottom nav) ──────────────
    GoRoute(
      path: '/onboarding',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OnboardingScreen(),
    ),
    // ─── Main Shell with Bottom Navigation ────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _ScaffoldWithNav(navigationShell: navigationShell);
      },
      branches: [
        // 🏦 Branch 1: Wallet
        StatefulShellBranch(
          navigatorKey: _walletNavigatorKey,
          routes: [
            GoRoute(
              path: '/wallet',
              builder: (context, state) => const WalletDashboardScreen(),
              routes: [
                GoRoute(
                  path: 'subscriptions',
                  builder: (context, state) => const SubscriptionsScreen(),
                ),
                GoRoute(
                  path: 'goals',
                  builder: (context, state) => const GoalsScreen(),
                ),
                GoRoute(
                  path: 'pac',
                  builder: (context, state) => const PacScreen(),
                ),
              ],
            ),
          ],
        ),
        // 📚 Branch 2: Academy
        StatefulShellBranch(
          navigatorKey: _academyNavigatorKey,
          routes: [
            GoRoute(
              path: '/academy',
              builder: (context, state) => const AcademyScreen(),
            ),
          ],
        ),
        // 🎮 Branch 3: Simulator
        StatefulShellBranch(
          navigatorKey: _simulatorNavigatorKey,
          routes: [
            GoRoute(
              path: '/simulator',
              builder: (context, state) => const SimulatorScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// Scaffold wrapper with persistent bottom navigation bar
class _ScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _ScaffoldWithNav({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.bgBottomNav,
          border: Border(
            top: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Wallet',
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => navigationShell.goBranch(0),
                ),
                _NavItem(
                  icon: Icons.school_rounded,
                  label: 'Academy',
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => navigationShell.goBranch(1),
                ),
                _NavItem(
                  icon: Icons.sports_esports_rounded,
                  label: 'Palestra',
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: () => navigationShell.goBranch(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
