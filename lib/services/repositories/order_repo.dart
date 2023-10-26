import 'dart:convert';
import 'package:doan/constants/app_url.dart';
import 'package:doan/controllers/product_controller.dart';
import 'package:doan/models/Booking.dart';
import 'package:doan/models/BookingItem.dart';
import 'package:doan/models/Cart.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderRepo extends GetxService {
  OrderRepo();

  Future<http.Response> getOrders() async {
    String token = await UserPreference().getToken();
    http.Response res = await http.get(
      Uri.parse(AppUrl.ORDERS),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return res;
  }

  Future<http.Response> createOrder(
    String uid,
    List<BookingItem> cart,
    String phoneNumber,
    num totalPrice,
  ) async {
    String token = await UserPreference().getToken();
    // var orderItems = jsonEncode(cart.map((e) => e.toJson()).toList());
    var orderItems = Get.find<ProductController>()
        .getBookingItems
        .map((e) => e.toJson())
        .toList();
    print("orderItems");
    print(orderItems);

    final Map<String, dynamic> orders = {
      'orderItems': orderItems,
      'user': uid,
      'phone_number': phoneNumber,
      'total_price': totalPrice,
    };
    print(json.encode(orders));

    http.Response response = await http.post(
      Uri.parse(AppUrl.ORDERS),
      body: json.encode(orders),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
