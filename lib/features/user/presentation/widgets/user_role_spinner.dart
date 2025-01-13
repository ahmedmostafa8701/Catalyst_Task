import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:flutter/material.dart';

class UserRoleSpinner extends StatefulWidget {
  final void Function(UserRole? role) onSelected;
  List<UserRole>? roles;
  UserRole? initialRole;
  final Color color;

  UserRoleSpinner({
    super.key,
    required this.onSelected,
    this.roles,
    this.initialRole,
    this.color = Colors.white,
  });

  @override State<UserRoleSpinner> createState() => _UserRoleSpinnerState();
}

class _UserRoleSpinnerState extends State<UserRoleSpinner> {
  @override
  Widget build(BuildContext context) {
    widget.roles ??= UserRole.values;
    return DropdownButton<UserRole>(
      iconEnabledColor: widget.color,
      iconDisabledColor: widget.color,
      hint: Text(
        'Select the role',
        style: TextStyle(color: widget.color),
      ),
      value: widget.initialRole,
      items: UserRole.values
          .map((role) => DropdownMenuItem<UserRole>(
                value: role,
                child: Text(role.name
                    .replaceFirst(role.name[0], role.name[0].toUpperCase())),
              ))
          .toList(),
      onChanged: (role){
        widget.onSelected(role);
        setState(() {
          widget.initialRole = role;
        });
      },
    );
  }
}
