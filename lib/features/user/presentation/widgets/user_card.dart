import 'package:cached_network_image/cached_network_image.dart';
import 'package:cataylst_task/core/custom_card.dart';
import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  UserModel userModel;
  void Function() onDelete;
  void Function() onEdit;
  void Function(UserModel userModel) onEditSuccess;

  UserCard(
      {required this.userModel,
      required this.onDelete,
      required this.onEdit,
      required this.onEditSuccess,
      super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                imageUrl: userModel.profileImage,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(width: horizontalPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    style: textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(userModel.email,
                      style: textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: colorScheme.error,
                ),
              ),
              SizedBox(width: 6.w),
              GestureDetector(
                onTap: onEdit,
                child: Icon(
                  Icons.edit,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: colorScheme.primary,
              ),
              Text(userModel.phone,
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          Center(
              child: Text(userModel.role,
                  style: textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}
