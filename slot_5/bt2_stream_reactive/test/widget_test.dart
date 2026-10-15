import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stream_reactive/screens/home_screen.dart';
import 'package:stream_reactive/services/stream_service.dart';

void main() {
  test('Stream emits data while UI is not built', () async {
    final service = StreamService();
    final emitted = <int>[];
    final sub = service.stream.listen(emitted.add);

    service.start();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    service.dispose();
    await sub.cancel();

    expect(emitted, isNotEmpty);
  });

  testWidgets('App renders counter from stream', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump();

    expect(find.text('Live Counter Stream App'), findsOneWidget);
    expect(find.byIcon(Icons.pause), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}