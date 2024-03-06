import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_with_rive/blocs/auth/auth_bloc.dart';
import 'package:login_bloc_with_rive/init/cache/auth_cache_manager.dart';
import 'package:login_bloc_with_rive/init/network/dio_manager.dart';
import 'package:login_bloc_with_rive/routes/app_router.dart';
import 'package:login_bloc_with_rive/service/auth_service.dart';

void main() {
  // runApp(const MainApp());
   HttpOverrides.global = MyHttpOverrides();
  runApp(
    BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
        AuthService(DioManager.instance),
        AuthCacheManager(),
      ),
      child: MainApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      routerConfig: appRouter.config(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      // home: const OnboardingScreen(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
