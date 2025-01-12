import 'package:cataylst_task/features/user/domain/models/user_model.dart';

abstract class UserRepo{
  Future<List<UserModel>> fetchUsers();
  Future<void> addUser(UserModel user);
  Future<void> deleteUser(int id);
  Future<void> updateUser(UserModel user);
}