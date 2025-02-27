import 'package:cached_network_image/cached_network_image.dart';
import 'package:cataylst_task/core/presentation/widgets/custom_card.dart';
import 'package:cataylst_task/features/user/domain/models/user_model.dart';
import 'package:cataylst_task/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  final UserModel userModel;
  final void Function() onDelete;
  final void Function() onEdit;

  const UserCard(
      {required this.userModel,
      required this.onDelete,
      required this.onEdit,
      super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var textWidth = 230.w;
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
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.black),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(width: horizontalPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: textWidth,
                    child: Text(
                      userModel.name,
                      overflow: TextOverflow.ellipsis, maxLines: 1, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: textWidth,
                    child: Text(userModel.email,
                      overflow: TextOverflow.ellipsis, maxLines: 1, style: textTheme.titleSmall?.copyWith(color: Colors.grey)),
                  ),
                ],
              ),
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
              SizedBox(
                width: textWidth,
                child: Text(userModel.phone,
                    maxLines: 1,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Center(
            child: Text(
              userModel.role.replaceFirst(
                  userModel.role[0], userModel.role[0].toUpperCase()),
              maxLines: 1,
              style:
                  textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
