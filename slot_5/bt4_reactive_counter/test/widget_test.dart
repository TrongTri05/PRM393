import 'package:flutter_test/flutter_test.dart';

import 'package:reactive_counter/main.dart';

void main() {
  testWidgets('Reactive Counter renders and updates via Stream', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Reactive Counter Demo'), findsOneWidget);
    expect(find.text('Reactive'), findsOneWidget);
    expect(find.text('Imperative'), findsOneWidget);
  });
}