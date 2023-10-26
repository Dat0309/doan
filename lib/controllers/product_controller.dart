import 'dart:convert';

import 'package:doan/constants/app_colors.dart';
import 'package:doan/controllers/booking_controller.dart';
import 'package:doan/controllers/cart_controller.dart';
import 'package:doan/models/BookingItem.dart';
import 'package:doan/models/Cart.dart';
import 'package:doan/models/Product.dart';
import 'package:doan/services/repositories/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> popularProducts = [];
  List<dynamic> categoryProducts = [];
  List<dynamic> restaurantProducts = [];

  bool isLoaded = false;
  bool isLoadedCategoryProducts = false;
  bool isLoadedRestaurantProduct = false;
  bool isLoadedReview = false;

  CartController _cart = Get.find<CartController>();
  BookingController _booking = Get.find<BookingController>();

  double get amount => cartTotalPrice + taxPrice + shipPrice;
  double get amountBooking => bookingTotalPrice.toDouble();

  final int _shipPrice = 3000;
  int get shipPrice => _shipPrice;

  final double _taxPrice = 0;
  double get taxPrice => _taxPrice * cartTotalPrice;

  int _quantity = 1;
  int get quantity => _quantity;

  int _bookingQuantity = 0;
  int get bookingQuantity => _bookingQuantity;

  int _inCartItem = 0;
  int get inCartItem => _inCartItem + _quantity;

  int _inBookingItem = 0;
  int get inBookingItem => _inBookingItem + _bookingQuantity;

  bool _itemExist = false;
  bool get itemExist => _itemExist;

  bool _itemBookingExist = false;
  bool get itemBookingExist => _itemBookingExist;

  int get cartTotalItem => _cart.totalItems;
  int get cartTotalPrice => _cart.totalPrice;
  int get bookingTotalItem => _booking.totalItems;
  int get bookingTotalPrice => _booking.totalPrice;

  void initProduct(Product product, CartController cartController,
      BookingController bookingController) {
    _cart = cartController;
    _quantity = 1;
    _inCartItem = 0;
    _itemExist = cartController.existInCart(product);

    _booking = bookingController;
    _bookingQuantity = 0;
    _inBookingItem = 0;
    _itemBookingExist = bookingController.existInBooking(product);
  }

  Future<void> getPopularProducts() async {
    await productRepo.getProductList().then((value) {
      if (value.statusCode == 200) {
        final Map<String, dynamic> resData = json.decode(value.body);

        if (resData['drinks'].length > 0) {
          popularProducts.clear();
          for (int i = 0; i < resData['drinks'].length; i++) {
            if (resData['drinks'][i] != null) {
              Map<String, dynamic> map = resData['drinks'][i];
              popularProducts.add(Product.fromMap(map));
            }
          }
          isLoaded = true;
          update();
        }
      } else {}
      return value;
    });
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQty(_quantity + 1);
    } else {
      _quantity = checkQty(_quantity - 1);
    }
    update();
  }

  void setBookingQuantity(bool isIncrement) {
    if (isIncrement) {
      _bookingQuantity = checkQty(_bookingQuantity + 1);
    } else {
      _bookingQuantity = checkQty(_bookingQuantity - 1);
    }
    update();
  }

  int checkQty(int qty) {
    if (qty < 0) {
      return 0;
    } else if (qty > 20) {
      Get.snackbar(
        'Số lượng mua',
        'Bạn chỉ được mua số lượng tối đa là 20 của một sản phẩm!',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
      return 20;
    }
    return qty;
  }

  void addItem(Product product) {
    if (_quantity > 0) {
      _cart.addItem(product, _quantity);
    } else {
      Get.snackbar(
        'Lỗi',
        'Xin hãy chọn số lượng sản phẩm trước khi thêm vào giỏ hàng!',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
    update();
  }

  void addBookingItem(Product product, int qty) {
    if (qty > 0) {
      _booking.addItem(product, qty);
    } else {
      Get.snackbar(
        'Lỗi',
        'Xin hãy chọn số lượng sản phẩm trước khi thêm vào giỏ hàng!',
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
    update();
  }

  void removeItem(Cart cart) {
    _cart.removeItem(cart);
  }

  void removeBookingItem(Product product) {
    if (_booking.existInBooking(product)) {
      _booking.removeItem(product);
    }
    update();
  }

  void updateBookingQty(String id, int qty) {
    _booking.updateItemQty(id, qty);
    update();
  }

  List<Cart> get getItems {
    return _cart.getItems;
  }

  List<BookingItem> get getBookingItems {
    print(_booking.getItems);
    return _booking.getItems;
  }

  Map<String, dynamic> get getItemJson {
    return _cart.items;
  }

  Map<String, dynamic> get getBookingItemJson {
    return _booking.items;
  }

  void clearCard() {
    _cart.clearCart();
  }

  void clearBooking() {
    _booking.clearBooking();
  }
}
