import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/cart/cart_bloc.dart';
import 'package:myntra/features/products/presentation/widgets/app_button.dart';
import 'package:myntra/features/products/presentation/widgets/quantity_change_dropdown.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    context.read<CartBloc>().add(const GetCart());
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    context.read<CartBloc>().add(const CartClear());
                  },
                  child: const Text('Clear Cart')),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = state.cartModel[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).colorScheme.surface,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.038),
                                  blurRadius: 12,
                                )
                              ],
                              border: Border.all(
                                color: const Color.fromARGB(19, 145, 145, 145),
                              ),
                            ),
                            child: ListTile(
                              leading: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.038),
                                        blurRadius: 12,
                                      )
                                    ],
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          19, 145, 145, 145),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      data.image,
                                    ),
                                  )),
                              title: Text(
                                data.title,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              subtitle: Column(
                                children: [
                                  Text(
                                    '₹${(data.price * data.quantity).toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  QUantityChangeWidget(cartItem: data),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: state.cartModel.length),
                    const SizedBox(height: 20),
                    if (state.cartModel.isNotEmpty)
                      AppButton(
                          text:
                              'Total: ₹${state.totalPrice.toStringAsFixed(1)}')
                    else
                      SizedBox(
                        height: screenHeight * 0.7,
                        child: const Center(
                          child: Text(
                            'Feeling empty?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
