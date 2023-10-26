import 'dart:convert';
import 'package:doan/constants/app_constant.dart';
import 'package:doan/models/BookingItem.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingRepo extends GetxService {
  final SharedPreferences sharedPreferences;
  BookingRepo({required this.sharedPreferences});

  List<String> booking = [];

  void addToBookingList(List<BookingItem> bookings) {
    sharedPreferences.remove(AppConstant.BOOKING);
    bookings.clear();

    for (var element in bookings) {
      booking.add(jsonEncode(element));
    }
    sharedPreferences.setStringList(AppConstant.BOOKING, booking);
    getBookingList();
  }

  List<BookingItem> getBookingList() {
    List<String> bookingList = [];
    if (sharedPreferences.containsKey(AppConstant.BOOKING)) {
      bookingList = sharedPreferences.getStringList(AppConstant.BOOKING)!;
    }
    List<BookingItem> bookings = [];
    for (var element in bookingList) {
      bookings.add(BookingItem.fromJson(jsonDecode(element)));
    }

    return bookings;
  }

  void clearBookingStorage() {
    booking.clear();
    sharedPreferences.remove(AppConstant.BOOKING);
  }
}
