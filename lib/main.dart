import 'package:assignment/presentation/auth/bloc/auth/auth_bloc.dart';
import 'package:assignment/presentation/auth/bloc/verify/verify_bloc.dart';
import 'package:assignment/presentation/auth/screen/auth_screen.dart';
import 'package:assignment/presentation/auth/screen/home_screen.dart';
import 'package:assignment/presentation/auth/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(create: (_) => OTPBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (_) => AuthScreen(),
            '/home-screen': (_) => HomeScreen()
          },
          initialRoute: '/',
        ));
  }
}
