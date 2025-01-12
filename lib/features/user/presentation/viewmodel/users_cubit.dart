import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:cataylst_task/features/user/domain/repo/user_repo.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class UsersCubit extends Cubit<UsersState>{
  final UserRepo _userRepo;
  List<UserModel> _users = [];
  TextEditingController spinnerController = TextEditingController();
  bool isFetched = false;
  UsersCubit(this._userRepo): super(UsersInitial());
  void fetchUsers() async{
    emit(UsersLoading());
    try{
      var users = await _userRepo.fetchUsers();
      _users = users;
      if (spinnerController.text.isNotEmpty && spinnerController.text.toLowerCase() != UserRole.all.name.toLowerCase()){
        filterString(spinnerController.text);
      }else
      {
        emit(UsersSuccess(users: users));
      }
    }catch(exception){
      emit(UsersError(message: exception.toString()));
    }
  }
  void addUser(UserModel userModel) async{
    emit(UsersLoading());
    try{
      await _userRepo.addUser(userModel);
      _users.add(userModel);
      emit(UsersSuccess(users: _users));
    }catch(exception){
      emit(UsersAddingError(message: exception.toString(), users: _users));
    }
  }
  void updateUser(UserModel userModel) async{
    emit(UsersLoading());
    try{
      await _userRepo.updateUser(userModel);
      _users[_users.indexWhere((element) => element.id == userModel.id)] = userModel;
      emit(UsersSuccess(users: _users));
    }catch(exception){
      emit(UsersUpdatingError(message: exception.toString(), users: _users));
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
  void filter(UserRole role){
    if(role == UserRole.all){
      emit(UsersSuccess(users: _users));
      return;
    }
    List<UserModel> filteredUsers = _users.where((user) => user.role.toLowerCase() == role.name.toLowerCase()).toList();
    emit(UsersSuccess(users: filteredUsers));
  }
  void filterString(String role){
    List<UserModel> filteredUsers = _users.where((user) => user.role.toLowerCase() == role.toLowerCase()).toList();
    emit(UsersSuccess(users: filteredUsers));
  }
}