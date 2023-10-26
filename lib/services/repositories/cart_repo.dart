import 'dart:convert';

import 'package:doan/constants/app_constant.dart';
import 'package:doan/models/Cart.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<Cart> carts) {
    sharedPreferences.remove(AppConstant.CART);
    cart.clear();
    /**
     * Chuyển định dạng dữ liệu từ json sang string vì sharedPreference chỉ nhậN dữ liệu string
     */
    for (var element in carts) {
      cart.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(AppConstant.CART, cart);
    getCartList();
  }

  List<Cart> getCartList() {
    List<String> cartList = [];
    if (sharedPreferences.containsKey(AppConstant.CART)) {
      cartList = sharedPreferences.getStringList(AppConstant.CART)!;
    }
    List<Cart> carts = [];

    for (var element in cartList) {
      carts.add(Cart.fromJson(jsonDecode(element)));
    }

    return carts;
  }

  void clearCartStorage() {
    cart.clear();
    sharedPreferences.remove(AppConstant.CART);
  }
}
