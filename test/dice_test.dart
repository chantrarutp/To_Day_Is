import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screen/dice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/theme_provider.dart';
import 'package:flutter_application_1/screen/LocaleProvidelanguage_provider.dart';

void main() {
  group('DiceScreen Tests', () {
    // Helper function to pump the DiceScreen widget
    Widget createWidgetForTesting() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MaterialApp(home: DiceScreen()),
      );
    }

    testWidgets('Select number of dice', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting());

      // Initial number of dice should be 1
      expect(find.text('1'), findsOneWidget);

      // Simulate tapping on the "3" button to select 3 dice
      await tester.tap(find.text('3'));
      await tester.pumpAndSettle();

      // Check if number of dice is now 3
      expect(
          tester.state<DiceScreenState>(find.byType(DiceScreen)).numberOfDice,
          3);
    });
  });
}
