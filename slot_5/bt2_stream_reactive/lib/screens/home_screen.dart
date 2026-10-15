import 'package:flutter/material.dart';

import '../services/stream_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StreamService _service = StreamService();

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

  void _toggle() {
    setState(() {
      if (_service.isRunning) {
        _service.pause();
      } else {
        _service.resume();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Counter Stream App')),
      body: Center(
        child: StreamBuilder<int>(
          stream: _service.stream,
          builder: (context, snapshot) {
            debugPrint('UI rebuild: ${snapshot.data}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 24, color: Colors.red),
              );
            }
            if (!snapshot.hasData) {
              return const Text('No data');
            }
            return Text(
              'Counter: ${snapshot.data}',
              style: const TextStyle(fontSize: 40),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: Icon(
          _service.isRunning ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}