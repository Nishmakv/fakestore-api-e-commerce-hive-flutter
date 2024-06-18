part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  fetching,
  fetched,
  cartCleared,
  priceUpdated,
  exception;
}

class CartState {
  final CartStatus status;
  final List<CartModel> cartModel;
  final double totalPrice;

  CartState({
    required this.status,
    this.cartModel = const [],
    this.totalPrice = 0.0,
  });

  factory CartState.initial() {
    return CartState(status: CartStatus.initial);
  }
  CartState copyWith({
    required CartStatus status,
    final List<CartModel>? cartModel,
    double? totalPrice,
  }) {
    return CartState(
      status: status,
      cartModel: cartModel ?? this.cartModel,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
