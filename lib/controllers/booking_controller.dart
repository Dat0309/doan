import 'package:doan/models/BookingItem.dart';
import 'package:doan/models/Product.dart';
import 'package:doan/services/repositories/booking_repo.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final BookingRepo bookingRepo;

  BookingController({required this.bookingRepo});

  Map<String, BookingItem> items = {};
  List<BookingItem> storageItems = [];

  List<dynamic> bookings = [];
  List<dynamic> userBookings = [];

  int get totalItems {
    var totalQuantity = 0;
    items.forEach((key, value) {
      totalQuantity += value.qty!;
    });
    //update();
    return totalQuantity;
  }

  int get totalPrice {
    var price = 0;
    items.forEach((key, value) {
      price += value.price!.toInt() * value.qty!;
      print(price);
    });
    return price;
  }

  set setBooking(List<BookingItem> listItems) {
    storageItems = listItems;
    for (var item in storageItems) {
      items.putIfAbsent(item.foodId!, () => item);
    }
  }

  void updateItemQty(String id, int qty) {
    if (items.containsKey(id)) {
      items.update(
          id,
          (value) => BookingItem(
                name: value.name,
                foodId: value.foodId,
                image: value.image,
                price: value.price,
                qty: qty,
              ));
    }
    update();
  }

  void removeItem(Product product) {
    items.remove(product.id);
    bookingRepo.addToBookingList(getItems);
    update();
  }

  void addItem(Product product, int qty) {
    if (items.containsKey(product.id)) {
      items.update(product.id!, (value) {
        return BookingItem(
          name: value.name,
          foodId: value.foodId,
          image: value.image,
          price: value.price,
          qty: value.qty! + qty,
        );
      });
      update();
    } else {
      items.putIfAbsent(
          product.id!,
          () => BookingItem(
                name: product.name,
                foodId: product.id,
                image: product.image,
                price: product.price,
                qty: qty,
              ));
    }
    bookingRepo.addToBookingList(getItems);
    update();
  }

  bool existInBooking(Product product) {
    if (items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  List<BookingItem> get getItems {
    return items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<BookingItem> getBookingData() {
    setBooking = bookingRepo.getBookingList();
    return storageItems;
  }

  void clearBooking() {
    bookingRepo.clearBookingStorage();
    items.clear();
    update();
  }
}
