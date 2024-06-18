part of 'products_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
  List<Object?> get props => [];
}

class GetProduct extends ProductEvent {
  const GetProduct();
}

class GetProductById extends ProductEvent {
  final int id;
  const GetProductById({required this.id});
}

class GetCategory extends ProductEvent {
  const GetCategory();
}

class GetCategoryByName extends ProductEvent {
  final String name;
  const GetCategoryByName({required this.name});
}

class AddProduct extends ProductEvent {
  final String title;
  final String price;
  final String description;
  final String category;
  const AddProduct({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });
}

class UpdateProduct extends ProductEvent {
  final int? id;
  final String title;
  final String price;
  final String description;
  final String category;
  const UpdateProduct({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });
}

class DeleteProduct extends ProductEvent {
  final int id;
  const DeleteProduct({
    required this.id,
  });
}

class SortProduct extends ProductEvent {
  final String order;
  const SortProduct({required this.order});
}

class NavIndexChange extends ProductEvent {
  final int index;
  NavIndexChange({required this.index});
}
