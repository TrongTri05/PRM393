import 'package:flutter/material.dart';

import '../widgets/summary_card.dart';
import '../widgets/responsive_grid.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final horizontalPadding = screenWidth * 0.04;
    final headerFontSize = screenWidth * 0.06;
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: headerFontSize.clamp(20, 32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // 1️⃣ Khu vực summary dùng LayoutBuilder
              const _SummarySection(),
              const SizedBox(height: 24),
              // 2️⃣ Khu vực grid sản phẩm tách ra widget riêng
              const ResponsiveProductGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // breakpoint đơn giản: < 600 là màn nhỏ
        final isNarrow = constraints.maxWidth < 600;
        // Tạo 3 summary cards làm ví dụ
        final cards = [
          const SummaryCard(
            title: 'Revenue',
            value: '\$12,300',
            color: Colors.blue,
          ),
          const SummaryCard(title: 'Orders', value: '320', color: Colors.green),
          const SummaryCard(
            title: 'Customers',
            value: '89',
            color: Colors.purple,
          ),
        ];
        if (isNarrow) {
          // Màn nhỏ: xếp dọc
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...cards.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: c,
                ),
              ),
            ],
          );
        } else {
          // Màn rộng: xếp ngang, dùng Expanded (sẽ giải thích kỹ ở bước 6)
          return Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
              const SizedBox(width: 12),
              Expanded(child: cards[2]),
            ],
          );
        }
      },
    );
  }
}
