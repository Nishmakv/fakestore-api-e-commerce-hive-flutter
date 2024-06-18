import 'package:bloc/bloc.dart';
import 'package:myntra/core/services/hive_services.dart';
import 'package:myntra/features/products/domain/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddToCart>(addCart);
    on<GetCart>(getCart);
    on<DropDownEvent>(dropDown);
    on<CartClear>(clearCart);
  }
  HiveService hiveService = HiveService();

  Future<void> addCart(
    AddToCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CartStatus.fetching));
      final response = await hiveService.addCartBox(event.cartModel);
      final totalPrice = calculatePrice(response);

      emit(state.copyWith(
          status: CartStatus.fetched,
          cartModel: response,
          totalPrice: totalPrice));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.exception));
    }
  }

  Future<void> getCart(
    GetCart event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.fetching));
    try {
      final response = await hiveService.getCartBox();
      final totalPrice = calculatePrice(response);
      emit(state.copyWith(
          status: CartStatus.fetched,
          cartModel: response,
          totalPrice: totalPrice));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.exception));
    }
  }

  Future<void> dropDown(
    DropDownEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.fetching));
    try {
      final dropDownItems =
          await hiveService.changeQuantity(event.value, event.newQuantity);
      final totalPrice = calculatePrice(dropDownItems);
      emit(state.copyWith(
          status: CartStatus.fetched,
          cartModel: dropDownItems,
          totalPrice: totalPrice));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.exception));
    }
  }

  Future<void> clearCart(
    CartClear event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(status: CartStatus.fetching));
    try {
      await hiveService.clearCart();

      emit(state.copyWith(
          status: CartStatus.cartCleared, cartModel: [], totalPrice: 0));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.exception));
    }
  }

  double calculatePrice(List<CartModel> items) {
    final totalPrice = items.fold(
      0.0,
      (total, element) => total + element.price * element.quantity,
    );
    return totalPrice;
  }
}
