class Product {
  // 1. Thuộc tính (Properties) - Dùng final vì dữ liệu không đổi sau khi tạo
  final String id;
  final String name;
  final double price;
  // 2. Constructor - Dùng Named Parameters và required
  Product({required this.id, required this.name, required this.price});
}
