import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:slot_4/main.dart';

void main() {
  testWidgets('App hiển thị lời chào và load danh sách sản phẩm', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Xin chào Hiếu'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('Táo'), findsOneWidget);
    expect(find.text('Cam'), findsOneWidget);
    expect(find.text('Chuối'), findsOneWidget);
  });
}