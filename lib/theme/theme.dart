import 'package:cataylst_task/theme/color.dart';
import 'package:cataylst_task/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


var theme = ThemeData(
  colorScheme: colorScheme,
  useMaterial3: true,
  textTheme: textTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.primary,
    elevation: 1,
    titleTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
);