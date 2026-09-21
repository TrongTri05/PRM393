import 'package:flutter/material.dart';

import '../widgets/counter_widget.dart';
import '../widgets/hello_widget.dart';
import '../widgets/profile_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  static const String studentName = 'Trí';
  static const String studentJob = 'Sinh viên Software Engineering';
  static const String whyFlutter =
      'Why I learn Flutter: một codebase chạy được cả Android, iOS, Web '
      'và Desktop, Hot Reload giúp thử UI trong vài giây thay vì vài phút.';

  @override
  Widget build(BuildContext context) {
    final String greeting = 'Hello Flutter, $studentName!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('My First Flutter App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 24),
              HelloWidget(message: greeting),
              const SizedBox(height: 20),
              const ProfileCard(
                name: studentName,
                job: studentJob,
                description: whyFlutter,
                avatarIcon: Icons.school,
              ),
              const SizedBox(height: 28),
              const CounterWidget(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}