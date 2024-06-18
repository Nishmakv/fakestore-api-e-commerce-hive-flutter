import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myntra/features/products/application/bloc/products/products_bloc.dart';
import 'package:myntra/features/products/domain/models/product_model.dart';

class AddScreen extends StatelessWidget {
  final ProductModel? productModel;
  const AddScreen({
    super.key,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: productModel?.title);
    TextEditingController priceController =
        TextEditingController(text: productModel?.price.toString());
    TextEditingController descriptionController =
        TextEditingController(text: productModel?.description);
    TextEditingController categoryController =
        TextEditingController(text: productModel?.category);
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.status == ProductStatus.fetched) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                productModel == null
                    ? 'added successfully'
                    : 'updated successfully',
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('title'),
                    hintText: 'enter title',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('price'),
                    hintText: 'enter price',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('description'),
                    hintText: 'enter description',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text('category'),
                    hintText: 'enter category',
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(
                          productModel == null
                              ? AddProduct(
                                  title: titleController.text,
                                  price: priceController.text,
                                  description: descriptionController.text,
                                  category: categoryController.text,
                                )
                              : UpdateProduct(
                                  title: titleController.text,
                                  price: priceController.text,
                                  description: descriptionController.text,
                                  category: categoryController.text,
                                ),
                        );
                  },
                  child: Text(
                    productModel == null ? 'Add Product' : 'Update Product',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
