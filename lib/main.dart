import 'package:cataylst_task/features/user/presentation/pages/users_page.dart';
import 'package:cataylst_task/providers.dart';
import 'package:cataylst_task/routes.dart';
import 'package:cataylst_task/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: ScreenUtilInit(
          designSize: const Size(411, 844),
          // Replace with your design's width and height
          minTextAdapt: true,
          // Ensures text scales appropriately
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Catalyst Task',
              theme: theme,
              routes: routes,
              initialRoute: UsersPage.routeName,
              debugShowCheckedModeBanner: false,
            );
          }
      ),
    );
  }
}
