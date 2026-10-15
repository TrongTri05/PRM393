import '../../models/user.dart';
import '../datasources/user_fake_datasource.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final UserFakeDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getUsers() {
    return dataSource.getUsers();
  }
}