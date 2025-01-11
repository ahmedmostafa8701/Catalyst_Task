import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/repo/user_repo.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UsersCubit extends Cubit<UsersState>{
  final UserRepo _userRepo;
  List<UserModel> _users = [];
  UsersCubit(this._userRepo): super(UsersInitial());
  void fetchUsers() async{
    emit(UsersLoading());
    try{
      var users = await _userRepo.fetchUsers();
      _users = users;
      emit(UsersSuccess(users: users));
    }catch(exception){
      emit(UsersError(message: exception.toString()));
    }
  }
  void deleteUser(UserModel userModel) async{
    emit(UsersLoading());
    try{
      await _userRepo.deleteUser(userModel.id);
      _users.remove(userModel);
      emit(UsersSuccess(users: _users));
    }catch(exception){
      emit(UsersDeletionError(message: exception.toString(), users: _users));
    }
  }
}