import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:myntra/features/products/domain/models/cart_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static const String hiveCartBox = 'cartBox';

  Future<void> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(CartModelAdapter());
  }

  Future<Box> cartBox() async {
    return await Hive.openBox(hiveCartBox);
  }

  Future addCartBox(CartModel cartModel) async {
    try {
      final box = await cartBox();
      await box.put(cartModel.id, cartModel);
      return getCartBox();
    } catch (e) {
      print(e);
    }
  }

  Future<List<CartModel>> getCartBox() async {
    final box = await cartBox();
    final items = box.values.cast<CartModel>().toList().reversed.toList();
    return items;
  }

  Future changeQuantity(int cartId, int newQuantity) async {
    final box = await cartBox();
    CartModel? cartItem = box.get(cartId);
    if (cartItem != null) {
      cartItem.quantity = newQuantity;
      await box.put(cartId, cartItem);
    }
    return getCartBox();
  }

  Future clearCart() async {
    final box = await cartBox();
    box.clear();
  }
}
