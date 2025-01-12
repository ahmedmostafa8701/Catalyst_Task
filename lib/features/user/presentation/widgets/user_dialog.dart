import 'package:cataylst_task/core/presentation/widgets/custom_elevated_button.dart';
import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:cataylst_task/features/user/presentation/widgets/user_role_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserDialog extends StatelessWidget {
  UserModel? userModel;
  final bool newInstance;
  final void Function(UserModel userModel) onPosting;

  UserDialog(
      {super.key,
      this.userModel,
      this.newInstance = true,
      required this.onPosting});

  @override
  Widget build(BuildContext context) {
    String actionName = newInstance ? 'Add' : 'Update';
    userModel ??= UserModel(id: 0, name: '', email: '', phone: '', role: '', profileImage: '');
    userModel?.profileImage = 'https://bio3.catalyst.com.eg/public/Catalyst_portfolio/IMG_0997%20(1).jpg';
    return AlertDialog(
      actionsOverflowAlignment: OverflowBarAlignment.start,

      title: Text(
        '$actionName User',
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 6.h,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'User name',
            ),
            onChanged: (value) {
              userModel?.name = value;
            },
            controller: TextEditingController(text: userModel?.name),
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
            onChanged: (value) {
              userModel?.email = value;
            },
            controller: TextEditingController(text: userModel?.email),
          ),
          const Text("Phone Number"),
          IntlPhoneField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'EG',
            onChanged: (phone) {
              userModel?.phone = phone.completeNumber;
            },
            controller: TextEditingController(text: userModel?.phone),
          ),
          const Text("Role"),
          UserRoleSpinner(
            onSelected: (role) {
              if(role != null)
              {
                userModel?.role = role.name;
              }
            },
            roles: const [UserRole.admin, UserRole.client, UserRole.owner],
            initialRole: UserRole.values.firstWhere(
                (element) => element.name == userModel?.role),
          ),
        ],
      ),
      actions: [
        CustomElevatedButton(
          onPressed: () {
            if(userModel?.name.isNotEmpty == true && userModel?.email.isNotEmpty == true && userModel?.phone.isNotEmpty == true && userModel?.role.isNotEmpty == true)
            {
              onPosting(userModel!);
              Navigator.of(context).pop();
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please fill all fields'),
                ),
              );
            }
          },
          labelText: actionName,
        ),
      ],
    );
  }
}
