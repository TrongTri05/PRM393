import 'dart:async';

import 'package:flutter/foundation.dart';

class CounterStreamService {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _counter = 0;

  Stream<int> get counterStream => _controller.stream;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _counter++;
      debugPrint('Emit counter: $_counter');
      _controller.add(_counter);
    });
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}