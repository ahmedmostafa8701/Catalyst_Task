import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/features/user/presentation/widgets/user_card.dart';
import 'package:cataylst_task/utils/contants.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  List<UserModel> users;

  UsersListView({required this.users, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserCard(userModel: users[index], onDelete: (){}, onEdit: (){},onEditSuccess: (userModel){},);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: verticalPadding,
          );
        },
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
