import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:myntra/features/products/domain/models/product_model.dart';
import 'package:myntra/features/products/domain/repositories/product_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Dio client = Dio();
  ProductBloc() : super(ProductState.initial()) {
    on<GetProduct>(onFetchProduct);
    on<GetProductById>(product);
    on<GetCategory>(category);
    on<GetCategoryByName>(getCategoryName);
    on<AddProduct>(productAdd);
    on<UpdateProduct>(updateProduct);
    on<DeleteProduct>(deleteProduct);
    on<SortProduct>(sortProduct);
    on<NavIndexChange>(navChange);
  }

  ProductRepo productRepo = ProductRepo();

  Future<void> onFetchProduct(
    GetProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.fetching));

    try {
      final response = await productRepo.getProducts();
      if (response.success ?? false) {
        emit(state.copyWith(
          status: ProductStatus.fetched,
          sortedProducts: response.data,
        ));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future<void> product(
    GetProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.fetching));

    try {
      final response = await productRepo.getProductById(event.id);
      if (response.success ?? false) {
        emit(state.copyWith(
            status: ProductStatus.fetched, product: response.data));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future<void> category(
    GetCategory event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final response = await productRepo.getCategories();
      if (response.isNotEmpty) {
        emit(state.copyWith(status: ProductStatus.fetched, category: response));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future<void> getCategoryName(
    GetCategoryByName event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.fetching));

    try {
      final response = await productRepo.getCategoryByName(event.name);
      if (response.isNotEmpty) {
        emit(state.copyWith(
          status: ProductStatus.fetched,
          categoryProducts: response,
        ));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future productAdd(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final response = await productRepo.addProduct(
        event.title,
        event.price,
        event.description,
        event.category,
      );
      if (response != null) {
        emit(state.copyWith(status: ProductStatus.fetched));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future updateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final response = await productRepo.updateProduct(
        event.id,
        event.title,
        event.price,
        event.description,
        event.category,
      );
      if (response != null) {
        emit(state.copyWith(status: ProductStatus.fetched));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future deleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final response = await productRepo.deleteProduct(
        event.id,
      );
      if (response != null) {
        emit(state.copyWith(status: ProductStatus.fetched));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future<void> sortProduct(
    SortProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final response = await productRepo.sortProducts(event.order);
      if (response.isNotEmpty) {
        emit(state.copyWith(
          status: ProductStatus.fetched,
          sortedProducts: response,
        ));
      } else {
        emit(state.copyWith(status: ProductStatus.exception));
      }
    } catch (e) {
      emit(state.copyWith(status: ProductStatus.exception));
    }
  }

  Future navChange(
    NavIndexChange event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.navIndexChanged, navIndex: event.index));
  }
}
