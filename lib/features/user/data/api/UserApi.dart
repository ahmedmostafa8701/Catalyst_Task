import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/repo/user_repo.dart';
import 'package:cataylst_task/utils/contants.dart';
import 'package:dio/dio.dart';

class UserApi extends UserRepo{
  Dio dio;
  final _path = BASE_URL + USERS_END_POINT;
  UserApi(this.dio);
  @override
  Future<int> addUser(UserModel user) async{
    var response = await dio.post(_path, data: user.toJson());
    return response.data['user']['id'];
  }

  @override
  Future<void> deleteUser(int id) async{
    await dio.delete('$_path/$id');
  }

  @override
  Future<List<UserModel>> fetchUsers() async{
    var response = await dio.get(_path);
    var usersJson = response.data as List;
    return usersJson.map((userJson) => UserModel.fromJson(userJson)).toList();
  }

  @override
  Future<void> updateUser(UserModel user) async{
    await dio.post('_path/${user.id}', data: user.toJson());
  }
}