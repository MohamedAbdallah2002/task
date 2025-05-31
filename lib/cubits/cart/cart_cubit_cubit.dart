import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task/cubits/cart/cart_cubit_state.dart';
import 'package:task/models/product.dart';
import 'package:task/services/hive_service.dart';


class CartCubit extends Cubit<CartState> {
  final HiveService hiveService;
  late Box cartBox;

  CartCubit({required this.hiveService}) : super(CartInitial()) {
    _init();
  }

  Future<void> _init() async {
    cartBox = await hiveService.openCartBox();
    emit(CartLoaded(_getCartItems()));
  }

  List<Product> _getCartItems() {
    return cartBox.values.map((item) => Product.fromJson(item)).toList();
  }

  void addToCart(Product product) {
    cartBox.put(product.id, {
      'id': product.id,
      'title': product.title,
      'price': product.price,
      'image': product.image,
    });
    emit(CartLoaded(_getCartItems()));
  }

  void removeFromCart(int productId) {
    cartBox.delete(productId);
    emit(CartLoaded(_getCartItems()));
  }

  bool isInCart(int productId) {
    return cartBox.containsKey(productId);
  }

  double getTotalPrice() {
    return _getCartItems().fold(0, (sum, item) => sum + item.price);
  }

  int getCartCount() {
    return _getCartItems().length;
  }
}