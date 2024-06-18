import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/presentation/pages/category_details_screen.dart';
import 'package:myntra/features/products/presentation/widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read();
    productBloc.add(const GetCategory());
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == ProductStatus.fetching) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state.status == ProductStatus.fetched) {
          return Scaffold(
            body: SafeArea(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    final data = state.category[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CategoryDetailScreen(name: data);
                              },
                            ),
                          );
                        },
                        child: CategoryCard(name: data));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: state.category.length),
            ),
          );
        } else
          // ignore: curly_braces_in_flow_control_structures
          return const Center(
            child: CircularProgressIndicator(),
          );
      
      },
    );
  }
}
