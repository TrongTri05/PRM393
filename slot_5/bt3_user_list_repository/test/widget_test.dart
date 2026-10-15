import 'package:flutter_test/flutter_test.dart';

import 'package:user_list_repository/data/datasources/user_fake_datasource.dart';
import 'package:user_list_repository/data/repositories/user_repository.dart';

void main() {
  test('Repository returns users without UI knowledge', () async {
    final repository = UserRepositoryImpl(UserFakeDataSource());
    final users = await repository.getUsers();

    expect(users.length, 3);
    expect(users.first.name, 'Alice');
  });
}