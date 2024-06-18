part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddToCart extends CartEvent {
  final CartModel cartModel;

  const AddToCart({
    required this.cartModel,
  });
}

class GetCart extends CartEvent {
  const GetCart();
}

class DropDownEvent extends CartEvent {
  final int value;
  final int newQuantity;
  DropDownEvent({required this.value, required this.newQuantity});
}

class CartClear extends CartEvent {
  const CartClear();
}
