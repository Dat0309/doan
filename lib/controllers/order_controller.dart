import 'dart:convert';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/controllers/user_controller.dart';
import 'package:doan/models/Booking.dart';
import 'package:doan/models/BookingItem.dart';
import 'package:doan/models/Cart.dart';
import 'package:doan/models/Order.dart';
import 'package:doan/services/preferences/user_preferences.dart';
import 'package:doan/services/repositories/order_repo.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  List<dynamic> orders = [];
  List<dynamic> userOrders = [];
  Order? order;
  CartController cartController = Get.find();

  bool isLoadedOrders = false;
  bool isLoadingOrder = false;
  bool isLoadedUserOrder = false;
  bool isCreated = false;

  Future<void> getOrders() async {
    isLoadingOrder = false;
    await orderRepo.getOrders().then((value) {
      if (value.statusCode == 200) {
        final Map<String, dynamic> resData = json.decode(value.body);

        if (resData.isNotEmpty) {
          orders.clear();
          for (var item in resData.values) {
            orders.add(Order.fromJson(item));
          }
          isLoadedOrders = true;
          update();
        }
      }
    });
  }

  Future<Map<String, dynamic>> createOrder(
    List<BookingItem> booking,
    String phoneNumber,
    num totalPrice,
  ) async {
    var result;
    var userController = Get.find<UserController>();
    String uid = await UserPreference().getUser().then((value) => value.id!);

    await orderRepo
        .createOrder(uid, booking, phoneNumber, totalPrice)
        .then((value) {
      if (value.statusCode == 201) {
        final Map<String, dynamic> resData = json.decode(value.body);
        Order order = Order.fromMap(resData['createOrder']);
        isCreated = true;
        userController.updateBalance(resData['updatedUser']['banking_balance']);
        result = {
          'status': true,
          'message': 'Successful',
          'order': order,
          'updatedUser': resData['updatedUser']
        };
        cartController.clearCart();
        update();
      } else {
        result = {
          'status': false,
          'message': 'error',
        };
        update();
      }
    });
    return result;
  }
}
