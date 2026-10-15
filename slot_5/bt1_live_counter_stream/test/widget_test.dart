import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:live_counter_stream/main.dart';

void main() {
  testWidgets('App renders counter from stream', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Live Counter Stream'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}