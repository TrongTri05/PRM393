import 'package:flutter/material.dart';

import 'data/datasources/user_fake_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'screens/user_screen.dart';

void main() {
  final userRepository = UserRepositoryImpl(UserFakeDataSource());

  runApp(MyApp(repository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List Repository Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UserScreen(repository: repository),
    );
  }
}