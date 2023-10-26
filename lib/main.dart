import 'dart:io';

import 'package:doan/controllers/auth_controller.dart';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/order_controller.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/views/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/dependencies.dart' as dep;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await dep.AppDependentcies.init();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().checkUserLogged();
    Get.find<ProductController>().getPopularProducts();
    Get.find<AuthController>();
    Get.find<OrderController>();
    Get.find<UserController>();
    Get.find<CartController>().getCartData();
    return const GetMaterialApp(
      title: 'ĂN GÌ ĐẶT NGAY!!!',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
