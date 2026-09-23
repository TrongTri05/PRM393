import 'package:flutter/material.dart';

import 'models/product.dart';
import 'services/product_service.dart';

void main() {
  runApp(MaterialApp(home: QuickShopPage()));
}

class QuickShopPage extends StatelessWidget {
  QuickShopPage({super.key});

  // 1️⃣ Tạo service (logic)
  final ProductService _service = ProductService();

  @override
  Widget build(BuildContext context) {
    // ✅ UI chỉ nhận KẾT QUẢ ĐÃ LỌC
    final products = _service.filterByMaxPrice(100);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm giá rẻ (< 100\$)"),
      ),
      body: ListView(
        children: products.map((product) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              onTap: () => _service.handleAddToCart(product),
            ),
          );
        }).toList(),
      ),
    );
  }
}
