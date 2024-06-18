part of 'products_bloc.dart';

enum ProductStatus {
  initial,
  fetching,
  fetched,
  navIndexChanged,
  exception,
}

class ProductState {
  final List<ProductModel> productModel;
  final ProductStatus status;
  final ProductModel? product;
  final List category;
  final List<ProductModel>? categoryProducts;
  final List<ProductModel> sortedProducts;
  final int navIndex;

  const ProductState({
    this.productModel = const [],
    required this.status,
    this.product,
    this.category = const [],
    this.categoryProducts = const [],
    this.sortedProducts = const [],
    this.navIndex=0,

  });
  factory ProductState.initial() {
    return const ProductState(
      status: ProductStatus.initial,
    );
  }

  ProductState copyWith({
    required ProductStatus status,
    final List<ProductModel>? productModel,
    final ProductModel? product,
    final List? category,
    final List<ProductModel>? categoryProducts,
    final List<ProductModel>? sortedProducts,
    final int?navIndex,
  }) {
    return ProductState(
      status: status,
      productModel: sortedProducts ?? this.productModel,
      product: product ?? this.product,
      category: category ?? this.category,
      categoryProducts: categoryProducts ?? this.categoryProducts,
      sortedProducts: sortedProducts ?? this.sortedProducts,
      navIndex: navIndex??this.navIndex,
    );
  }
}
