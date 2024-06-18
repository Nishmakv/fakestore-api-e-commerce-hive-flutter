import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/core/widgets/widgets.dart';
import 'package:myntra/features/auth/auth.dart';
import 'package:myntra/features/products/presentation/pages/nav_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.fetched) {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return const NavScreen();
            },
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  AppTextField(
                    label: 'Username',
                    hintText: 'Enter your username',
                    controller: usernameController,
                  ),
                  const SizedBox(height: 10),
                  AppTextField(
                    label: 'Password',
                    hintText: 'Enter your password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(UserLogin(
                            username: usernameController.text,
                            password: passwordController.text,
                          ));
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
