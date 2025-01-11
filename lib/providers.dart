import 'package:cataylst_task/features/user/data/api/UserApi.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider<UsersCubit>(
    create: (context) => UsersCubit(UserApi(Dio())),
  ),
];