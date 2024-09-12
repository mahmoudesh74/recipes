import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/cubits/recipes_cubit/cubit.dart';
import 'package:recipe/presentation/views/add_recipe/view.dart';
import 'package:recipe/presentation/views/home/view.dart';
import 'package:recipe/presentation/views/user_auth/log_in/login.dart';

import 'core/logic/helper_methods.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: BlocProvider(
        create: (context) => RecipeCubit(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white,elevation: 0,surfaceTintColor: Colors.transparent),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const LogIn(),
        ),
      ),
    );
  }
}
