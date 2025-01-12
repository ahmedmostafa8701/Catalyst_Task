import 'package:cataylst_task/core/presentation/widgets/custom_elevated_button.dart';
import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:cataylst_task/features/user/presentation/pages/users_page.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_cubit.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_state.dart';
import 'package:cataylst_task/features/user/presentation/widgets/user_dialog.dart';
import 'package:cataylst_task/features/user/presentation/widgets/user_role_spinner.dart';
import 'package:cataylst_task/features/user/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    if(!BlocProvider.of<UsersCubit>(context).isFetched){
      BlocProvider.of<UsersCubit>(context).fetchUsers();
      BlocProvider.of<UsersCubit>(context).isFetched = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Users'),
            const Spacer(),
            UserRoleSpinner(
              onSelected: (role) {
                BlocProvider.of<UsersCubit>(context)
                    .filter(role ?? UserRole.all);
              },
            ),
            Spacer(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<UsersCubit>(context).fetchUsers();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed function here
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => UserDialog(
              onPosting: (userModel) {
                BlocProvider.of<UsersCubit>(context).addUser(userModel);
              },
              userModel: UserModel(id: 0, name: '', email: '', phone: '', profileImage: '', role: UserRole.client.name),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersSuccess) {
            return UsersListView(users: state.users);
          } else if (state is UsersError) {
            return Center(
                child: Text(
              state.message,
              style: TextStyle(color: colorScheme.error),
            ));
          } else if (state is UsersDeletionError) {
            return UsersListView(users: state.users);
          }else if (state is UsersAddingError) {
            return UsersListView(users: state.users);
          }else if (state is UsersUpdatingError) {
            return UsersListView(users: state.users);
          } else {
            return const Center(child: Text('No users found'));
          }
        },
        listener: (BuildContext context, state) {
          if (state is UsersDeletionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "failed to delete because: ${state.message}",
                  style: TextStyle(color: colorScheme.error),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          } else if (state is UsersAddingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "failed to add because: ${state.message}",
                  style: TextStyle(color: colorScheme.error),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }
          else if (state is UsersUpdatingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "failed to update because: ${state.message}",
                  style: TextStyle(color: colorScheme.error),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
