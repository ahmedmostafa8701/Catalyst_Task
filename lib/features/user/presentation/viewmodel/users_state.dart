import 'package:cataylst_task/features/user/domain/models/user_model.dart';

class UsersState{}
class UsersLoading extends UsersState{}
class UsersSuccess extends UsersState{
  final List<UserModel> users;
  UsersSuccess({required this.users});
}
class UsersError extends UsersState{
  final String message;
  UsersError({required this.message});
}
class UsersDeletionError extends UsersState{
  final String message;
  final List<UserModel> users;
  UsersDeletionError({required this.message, required this.users});
}
class UsersInitial extends UsersState{}