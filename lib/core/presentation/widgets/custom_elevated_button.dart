import 'package:cataylst_task/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.labelText,
      this.formKey,
      this.focusNode,
      this.isPrimary = true,
      this.isLoading = false,
      this.textSize});

  final bool isLoading;

  final GlobalKey<FormState>? formKey;
  final void Function()? onPressed;
  final String labelText;
  final double? textSize;
  FocusNode? focusNode;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: light,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: darkGrey,
          disabledBackgroundColor: grey,
          // side: const BorderSide(color: ConstantColors.primary),
          padding: EdgeInsets.symmetric(vertical: 18.0.h),
          textStyle: TextStyle(
              fontSize: textSize ?? 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(labelText),
      ),
    );
  }
}
