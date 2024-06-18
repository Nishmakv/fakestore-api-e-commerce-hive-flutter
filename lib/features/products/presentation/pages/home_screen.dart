import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/presentation/pages/cart_screen.dart';
import 'package:myntra/features/products/presentation/widgets/product_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(const GetProduct());

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
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Products'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showMenu<String>(
                            context: context,
                            position:
                                const RelativeRect.fromLTRB(100, 100, 0, 0),
                            items: [
                              const PopupMenuItem(
                                value: 'asc',
                                child: Text('asc'),
                              ),
                              const PopupMenuItem(
                                value: 'desc',
                                child: Text('desc'),
                              ),
                            ],
                          );

                          if (result == 'asc' || result == 'desc') {
                            // ignore: use_build_context_synchronously
                            context
                                .read<ProductBloc>()
                                .add(SortProduct(order: result!));
                          }
                        },
                        icon: const Icon(
                          Icons.sort,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const CartScreen();
                            },
                          ));
                        },
                        icon: const Icon(Icons.card_travel_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(const GetProduct());
                },
                child: ProductGrid(
                  productModel: state.productModel,
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
