import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/cart/cart_cubit_cubit.dart';
import 'package:task/screens/products_screen.dart';
import 'cubits/product/product_cubit.dart';
import 'services/api_service.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();

  runApp(MyApp(hiveService: hiveService));
}

class MyApp extends StatelessWidget {
  final HiveService hiveService;

  const MyApp({super.key, required this.hiveService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ProductCubit(apiService: ApiService())..fetchProducts(),
        ),
        BlocProvider(create: (context) => CartCubit(hiveService: hiveService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ProductListScreen(),
      ),
    );
  }
}
