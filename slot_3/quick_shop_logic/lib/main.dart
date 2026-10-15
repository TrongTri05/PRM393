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
    // ❌ KHÔNG xử lý logic ở đây
    // ✅ Chỉ lấy KẾT QUẢ đã xử lý
    final List<Product> products = _service.getCheapProducts();
    return Scaffold(
      appBar: AppBar(title: const Text("Quick Shop - Sản phẩm giá rẻ")),
      body: ListView(
        children: products.map((product) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(product.name),
              subtitle: Text("\$${product.price}"),
              trailing: const Icon(Icons.add_shopping_cart),
              // UI chỉ GỌI logic
              onTap: () => _service.handleAddToCart(product),
            ),
          );
        }).toList(),
      ),
    );
  }
}
