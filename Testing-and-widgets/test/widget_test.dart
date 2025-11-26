import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test12/widgets.dart'; // <--- CAMBIO IMPORTANTE: package:test12

void main() {
  group('Parte 3: Widget Testing', () {
    
    testWidgets('LEDWidget should be green when isOn is true', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: LEDWidget(isOn: true)),
      ));

      final iconFinder = find.byIcon(Icons.lightbulb);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, Colors.green);
    });

    testWidgets('LEDWidget should be grey when isOn is false', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: LEDWidget(isOn: false)),
      ));

      final iconFinder = find.byIcon(Icons.lightbulb);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, Colors.grey);
    });

    testWidgets('ControlPanelWidget should show counter at 0 initially', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ControlPanelWidget()),
      ));
      expect(find.text('Contador: 0'), findsOneWidget);
    });

    testWidgets('ControlPanelWidget should increment to 1 after one tap', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ControlPanelWidget()),
      ));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); 

      expect(find.text('Contador: 1'), findsOneWidget);
    });

    testWidgets('ControlPanelWidget should increment to 5 after five taps', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: ControlPanelWidget()),
      ));

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
      }

      expect(find.text('Contador: 5'), findsOneWidget);
    });
  });
}