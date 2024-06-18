import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/presentation/widgets/product_grid.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String name;
  const CategoryDetailScreen({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = context.read();
    productBloc.add(GetCategoryByName(name: name));
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
        } else if (state.categoryProducts != null) {
          return Scaffold(
            body: SafeArea(
              child: ProductGrid(productModel: state.categoryProducts!),
            ),
          );
        } else {
          return const Text('no data');
        }
      },
    );
  }
}
