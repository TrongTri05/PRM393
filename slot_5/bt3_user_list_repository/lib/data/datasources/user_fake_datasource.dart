import '../../models/user.dart';

class UserFakeDataSource {
  Future<List<User>> getUsers() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return const [
      User(id: 1, name: 'Alice'),
      User(id: 2, name: 'Bob'),
      User(id: 3, name: 'Charlie'),
    ];
  }
}