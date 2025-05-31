import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/cart/cart_cubit_cubit.dart';
import 'package:task/cubits/cart/cart_cubit_state.dart';
import 'package:task/screens/cart_screen.dart';
import 'package:task/widgets/product_item.dart';
import '../cubits/product/product_cubit.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Badge(
                    label: Text(state.cartItems.length.toString()),
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return const Icon(Icons.shopping_cart);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductItem(product: product);
              },
            );
          }
          return const Center(child: Text('No products available'));
        },
      ),
    );
  }
}
