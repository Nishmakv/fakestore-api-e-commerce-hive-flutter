import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/cart/cart_bloc.dart';
import 'package:myntra/features/products/domain/models/cart_model.dart';

class QUantityChangeWidget extends StatelessWidget {
  final CartModel cartItem;
  const QUantityChangeWidget({
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButton(
            value: cartItem.quantity,
            items: const [
              DropdownMenuItem(value: 1, child: Text('1')),
              DropdownMenuItem(value: 2, child: Text('2')),
              DropdownMenuItem(value: 3, child: Text('3')),
              DropdownMenuItem(value: 4, child: Text('4')),
              DropdownMenuItem(value: 5, child: Text('5')),
            ],
            onChanged: (value) {
              if (value != null) {
                context
                    .read<CartBloc>()
                    .add(DropDownEvent(value: cartItem.id, newQuantity: value));
              }
            });
      },
    );
  }
}
