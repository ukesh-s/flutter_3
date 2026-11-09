import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_3/main.dart';

void main() {
  testWidgets('shows searchable product catalog', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Product Explorer'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsOneWidget);
  });
  testWidgets('filters products as search text changes', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.enterText(find.byType(TextField), 'mug');
    await tester.pumpAndSettle();
    expect(find.text('Travel Mug'), findsOneWidget);
    expect(find.text('Wireless Headphones'), findsNothing);
  });
}
