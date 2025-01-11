import 'package:cataylst_task/features/user/presentation/viewmodel/users_cubit.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_state.dart';
import 'package:cataylst_task/features/user/presentation/widgets/users_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    BlocProvider.of<UsersCubit>(context).fetchUsers();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
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
          }
        },
      ),
    );
  }
}
