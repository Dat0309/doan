import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/controllers/booking_controller.dart';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/order_controller.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/services/repositories/auth_repo.dart';
import 'package:doan/services/repositories/booking_repo.dart';
import 'package:doan/services/repositories/cart_repo.dart';
import 'package:doan/services/repositories/order_repo.dart';
import 'package:doan/services/repositories/product_repo.dart';
import 'package:doan/services/repositories/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependentcies {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ProductRepo());
    Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
    Get.lazyPut(() => AuthRepo(sharedPreferences: Get.find()));
    Get.lazyPut(() => OrderRepo());
    Get.lazyPut(() => UserRepo(sharedPreferences: Get.find()));
    Get.lazyPut(() => BookingRepo(sharedPreferences: Get.find()));

    Get.lazyPut(() => ProductController(productRepo: Get.find()));
    Get.lazyPut(() => CartController(cartRepo: Get.find()));
    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => OrderController(orderRepo: Get.find()));
    Get.lazyPut(() => UserController(userRepo: Get.find()));
    Get.lazyPut(() => BookingController(bookingRepo: Get.find()));
  }
}
