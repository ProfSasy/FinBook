import 'package:flutter_test/flutter_test.dart';
import 'package:finbook/main.dart';

void main() {
  testWidgets('FinBook app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const FinBookApp());
    expect(find.text('Il tuo Wallet'), findsOneWidget);
  });
}
