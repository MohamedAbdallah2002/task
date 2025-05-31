import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String cartBoxName = 'cart';
  static const String tokenBoxName = 'token';

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box> openCartBox() async {
    return await Hive.openBox(cartBoxName);
  }

  Future<Box> openTokenBox() async {
    return await Hive.openBox(tokenBoxName);
  }
}
