import 'dart:async';

import 'package:flutter/foundation.dart';

class StreamService {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _counter = 0;
  bool _running = false;

  Stream<int> get stream => _controller.stream;
  bool get isRunning => _running;

  void start() {
    if (_running) return;
    _running = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _counter++;
      debugPrint('Emit counter: $_counter');
      _controller.add(_counter);
    });
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
    _running = false;
    debugPrint('Stream paused at: $_counter');
  }

  void resume() {
    start();
    debugPrint('Stream resumed');
  }

  void dispose() {
    pause();
    if (!_controller.isClosed) {
      _controller.close();
    }
    debugPrint('StreamController closed');
  }
}