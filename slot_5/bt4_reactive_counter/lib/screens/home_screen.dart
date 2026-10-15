import 'package:flutter/material.dart';

import '../services/counter_stream_service.dart';

class ImperativeCounter extends StatefulWidget {
  const ImperativeCounter({super.key});

  @override
  State<ImperativeCounter> createState() => _ImperativeCounterState();
}

class _ImperativeCounterState extends State<ImperativeCounter> {
  int _counter = 0;

  void _increase() {
    setState(() {
      _counter++;
      debugPrint('UI decides to update: $_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Imperative UI (setState)', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _increase,
            icon: const Icon(Icons.add),
            label: const Text('Tăng (UI ra lệnh)'),
          ),
        ],
      ),
    );
  }
}

class ReactiveCounter extends StatefulWidget {
  const ReactiveCounter({super.key});

  @override
  State<ReactiveCounter> createState() => _ReactiveCounterState();
}

class _ReactiveCounterState extends State<ReactiveCounter> {
  final CounterStreamService _service = CounterStreamService();

  @override
  void initState() {
    super.initState();
    _service.start();
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _service.counterStream,
      builder: (context, snapshot) {
        debugPrint('UI rebuild: ${snapshot.data}');
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Reactive UI (Stream)', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              if (snapshot.hasError)
                Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                )
              else if (snapshot.hasData)
                Text(
                  '${snapshot.data}',
                  style: const TextStyle(fontSize: 48),
                )
              else
                const Text('Waiting...'),
              const SizedBox(height: 24),
              const Text(
                'UI tự cập nhật khi dữ liệu đổi (không setState)',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reactive Counter Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Imperative'),
              Tab(text: 'Reactive'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ImperativeCounter(),
            ReactiveCounter(),
          ],
        ),
      ),
    );
  }
}