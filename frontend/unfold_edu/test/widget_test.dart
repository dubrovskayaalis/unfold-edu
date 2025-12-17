import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:unfold_edu/main.dart';

void main() {
  testWidgets('App renders HomeScreen with two actions', (WidgetTester tester) async {
    await tester.pumpWidget(const UnfoldEduApp());

    expect(find.text('Unfold EDU'), findsOneWidget);
    expect(find.text('Upload photos'), findsOneWidget);
    expect(find.text('View artifacts'), findsOneWidget);
  });
}
