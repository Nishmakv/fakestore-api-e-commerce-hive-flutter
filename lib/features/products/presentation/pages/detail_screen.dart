import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/cart/cart_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/domain/models/cart_model.dart';
import 'package:myntra/features/products/presentation/pages/cart_screen.dart';
import 'package:myntra/features/products/presentation/widgets/app_button.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ProductBloc byId = context.read();
    byId.add(GetProductById(id: id));
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
            if (state.product != null) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Image.network(
                            state.product!.image,
                            width: 250,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.product!.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.product!.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(width: 8),
                                    Text('${state.product!.rate.rate}/5'),
                                    const SizedBox(width: 5),
                                    Text(
                                        '(${state.product?.rate.count ?? ''})'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '₹${state.product!.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                const Text('Inclusive of all taxes'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                                onTap: () {
                                  context.read<CartBloc>().add(
                                        AddToCart(
                                          cartModel: CartModel(
                                            title: state.product!.title,
                                            price: state.product!.price,
                                            image: state.product!.image,
                                            id: state.product!.id,
                                            quantity: 1,
                                          ),
                                        ),
                                      );

                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const CartScreen();
                                    },
                                  ));
                                },
                                child: const AppButton(text: 'Add to bag')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Text('no product');
            }
          } else if (state.status == ProductStatus.exception) {
            return const Text('error');
          } else {
            return const Text('error');
          }
        });
  }
}
