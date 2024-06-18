import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/presentation/pages/cart_screen.dart';
import 'package:myntra/features/products/presentation/pages/category_screen.dart';
import 'package:myntra/features/products/presentation/pages/home_screen.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List screens = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
    ];

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: screens[state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              context.read<ProductBloc>().add(NavIndexChange(index: value));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_travel),
                label: 'Cart',
              ),
            ],
            currentIndex: state.navIndex,
          ),
        );
      },
    );
  }
}
