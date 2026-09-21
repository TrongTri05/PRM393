import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key, this.initialValue = 0});

  final int initialValue;

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late int count = widget.initialValue;

  void _increase() {
    setState(() {
      count++;
    });
  }

  void _decrease() {
    setState(() {
      count--;
    });
  }
  void _reset() {
    setState(() {
      count = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Count: $count',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _decrease,
              icon: const Icon(Icons.remove),
              label: const Text('Decrease'),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _increase,
              icon: const Icon(Icons.add),
              label: const Text('Increase'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: _reset,
          icon: Icon(Icons.refresh, color: colors.error),
          label: Text('Reset', style: TextStyle(color: colors.error)),
        ),
      ],
    );
  }
}