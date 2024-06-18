import 'package:dio/dio.dart';
import 'package:myntra/core/network/network.dart';
import 'package:myntra/features/products/domain/models/product_model.dart';

class ProductRepo {
  Dio client = Dio();

  Future<Result<List<ProductModel>>> getProducts() async {
    try {
      final response = await client.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        final product = response.data as List<dynamic>;
        final result = product.map((e) => ProductModel.fromJson(e)).toList();
        return Result.success(result);
      } else {
        return Result.failure('Api fetching failed');
      }
    } catch (e) {
      return Result.failure('An error occurred');
    }
  }

  Future<Result<ProductModel?>> getProductById(int id) async {
    try {
      final response =
          await client.get('https://fakestoreapi.com/products/$id');
      if (response.statusCode == 200) {
        final product = response.data;
        final result = ProductModel.fromJson(product);
        return Result.success(result);
      } else {
        return Result.failure('Api fetching failed');
      }
    } catch (e) {
      return Result.failure('An error occurred');
    }
  }

  Future<List> getCategories() async {
    try {
      final response =
          await client.get('https://fakestoreapi.com/products/categories');

      if (response.statusCode == 200) {
        final category = response.data as List;

        return category;
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  Future<List<ProductModel>> getCategoryByName(String name) async {
    try {
      final response =
          await client.get('https://fakestoreapi.com/products/category/$name');

      if (response.statusCode == 200) {
        final category = response.data as List;
        final result = category.map((e) => ProductModel.fromJson(e)).toList();
        return result;
      }
    } catch (e) {
      return [];
    }
    return [];
  }

  Future addProduct(
    final String title,
    final String price,
    final String description,
    final String category,
  ) async {
    try {
      final response =
          await client.post('https://fakestoreapi.com/products', data: {
        'title': title,
        'price': price,
        'description': description,
        'category': category,
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future updateProduct(
    final int? id,
    final String title,
    final String price,
    final String description,
    final String category,
  ) async {
    try {
      final response =
          await client.put('https://fakestoreapi.com/products/$id', data: {
        'title': title,
        'price': price,
        'description': description,
        'category': category,
      });

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future deleteProduct(final int id) async {
    try {
      final response = await client.delete(
        'https://fakestoreapi.com/products/$id',
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductModel>> sortProducts(final String order) async {
    try {
      final response =
          await client.get('https://fakestoreapi.com/products?sort=$order');
      if (response.statusCode == 200) {
        final product = response.data as List;
        final result = product.map((e) => ProductModel.fromJson(e)).toList();

        return result;
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
