
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:setstate/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);

    expect(find.text("setState"), findsOneWidget);
  });
}
