import 'package:flutter/material.dart';

import '../services/counter_stream_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Live Counter Stream')),
      body: Center(
        child: StreamBuilder<int>(
          stream: _service.counterStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text(
                'Có lỗi xảy ra: ${snapshot.error}',
                style: const TextStyle(fontSize: 20, color: Colors.red),
              );
            }

            if (!snapshot.hasData) {
              return const Text('Chưa có dữ liệu');
            }

            return Text(
              'Counter: ${snapshot.data}',
              style: const TextStyle(fontSize: 32),
            );
          },
        ),
      ),
    );
  }
}