import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/product.dart';
import '../../services/api_service.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ApiService apiService;

  ProductCubit({required this.apiService}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await apiService.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}