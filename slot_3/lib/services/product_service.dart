// lib/services/product_service.dart
import '../models/product.dart';
import '../data/data_source.dart';
class ProductService {
  /// Lấy toàn bộ sản phẩm
  List<Product> getAllProducts() {
    return rawProducts;
  }
  /// Lấy sản phẩm giá rẻ (< 100)
  List<Product> getCheapProducts() {
    return rawProducts.where((p) => p.price < 100).toList();
  }
  /// Xử lý khi người dùng chọn sản phẩm
  void handleAddToCart(Product product) {
    print("Đã chọn mua: ${product.name}");
    print("Giá tiền: ${product.price}");
  }

  /// Lọc sản phẩm theo giá tối đa
  List<Product> filterByMaxPrice(double maxPrice) {
    return rawProducts.where((product) {
      return product.price < maxPrice;
    }).toList();
  }
}