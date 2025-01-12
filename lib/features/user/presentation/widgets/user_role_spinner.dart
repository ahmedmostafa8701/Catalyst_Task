import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:cataylst_task/features/user/presentation/viewmodel/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRoleSpinner extends StatelessWidget {
  final void Function(UserRole? role) onSelected;
  List<UserRole>? roles;
  final UserRole? initialRole;
  UserRoleSpinner({
    super.key,
    required this.onSelected,
    this.roles,
    this.initialRole,
  });

  @override
  Widget build(BuildContext context) {
    roles ??= UserRole.values;
    return DropdownMenu(
      initialSelection: initialRole ?? roles?.first,
      controller: BlocProvider.of<UsersCubit>(context).spinnerController,
      onSelected: onSelected,
      dropdownMenuEntries: (roles ?? UserRole.values)
          .map((role) => DropdownMenuEntry(
        value: role,
        label: role.name
            .replaceFirst(role.name[0], role.name[0].toUpperCase()),
      ))
          .toList(),
    );
  }
}