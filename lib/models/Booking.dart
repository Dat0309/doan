// ignore_for_file: file_names

class Booking {
  String? id;
  String? userId;
  String? phoneNumber;
  List<dynamic>? bookingItem;
  num? totalPrice;

  Booking({
    this.id,
    this.phoneNumber,
    this.userId,
    this.bookingItem,
    this.totalPrice,
  });

  factory Booking.fromJson(Map<String, dynamic> res) {
    return Booking(
      id: res['id'],
      phoneNumber: res['phone_number'],
      userId: res['user_id'],
      bookingItem: res['booking_items'],
      totalPrice: res['total_price'],
    );
  }
}
