import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/core/services/hive_services.dart';
import 'package:myntra/features/auth/application/bloc/login_bloc.dart';
import 'package:myntra/features/products/application/bloc/cart/cart_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/auth/presentation/pages/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ProductBloc(),
      ),
      BlocProvider(
        create: (context) => LoginBloc(),
      ),
      BlocProvider(
        create: (context) => CartBloc(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
