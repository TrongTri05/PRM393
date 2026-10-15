import 'dart:async';

class CounterStreamService {
  final StreamController<int> _controller = StreamController<int>();
  Timer? _timer;
  int _count = 0;

  Stream<int> get counterStream => _controller.stream;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _count++;
      _controller.add(_count);
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