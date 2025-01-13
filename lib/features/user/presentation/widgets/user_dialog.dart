import 'package:cataylst_task/core/presentation/widgets/custom_elevated_button.dart';
import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/domain/models/user_roles.dart';
import 'package:cataylst_task/features/user/presentation/widgets/user_role_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserDialog extends StatelessWidget {
  final UserModel userModel;
  final bool newInstance;
  final void Function(UserModel userModel) onPosting;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  UserDialog(
      {super.key,
      required this.userModel,
      this.newInstance = true,
      required this.onPosting});
  @override
  Widget build(BuildContext context) {
    nameController.text = userModel.name;
    emailController.text = userModel.email;
    phoneController.text = userModel.phone;
    String actionName = newInstance ? 'Add' : 'Update';
    return AlertDialog(
      actionsOverflowAlignment: OverflowBarAlignment.start,
      title: Text(
        '$actionName User',
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10.h,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'User name',
              ),
              controller: nameController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              controller: emailController,
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
                userModel.phone = phone.completeNumber;
              },
              controller: phoneController,
            ),
            const Text("Role"),
            UserRoleSpinner(
              onSelected: (role) {
                if(role != null)
                {
                  userModel.role = role.name;
                }
              },
              roles: const [UserRole.admin, UserRole.client, UserRole.owner],
              initialRole: UserRole.values.firstWhere((element) => element.name == userModel.role),
              color: Colors.black,
            ),
          ],
        ),
      ),
      actions: [
        CustomElevatedButton(
          onPressed: () {
            userModel.name = nameController.text;
            userModel.email = emailController.text;
            if(userModel.name.isNotEmpty == true && userModel.email.isNotEmpty == true && userModel.phone.isNotEmpty == true && userModel.role.isNotEmpty == true)
            {
              onPosting(userModel);
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
