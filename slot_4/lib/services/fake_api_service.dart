import 'package:flutter/foundation.dart';

import '../models/item.dart';

class FakeApiService {
  static Future<List<Item>> fetchItems() async {
    debugPrint(' 1. BẮT ĐẦU gọi fetchItems');
    await Future<void>.delayed(const Duration(seconds: 2));
    debugPrint(' 2. SAU khi Future.delayed xong');
    return [
      Item(name: 'Táo', price: 10000),
      Item(name: 'Cam', price: 15000),
      Item(name: 'Chuối', price: 8000),
    ];
  }
}
