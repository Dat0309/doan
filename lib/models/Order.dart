// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Order {
  String? id;
  String? user;
  List<OrderItem>? orderItems;
  num? totalPrice;
  String? phoneNumber;
  String? paidAt;
  Order({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.phoneNumber,
    this.paidAt,
  });

  Order copyWith({
    String? id,
    String? user,
    List<OrderItem>? orderItems,
    num? totalPrice,
    String? phoneNumber,
    String? paidAt,
  }) {
    return Order(
      id: id ?? this.id,
      user: user ?? this.user,
      orderItems: orderItems ?? this.orderItems,
      totalPrice: totalPrice ?? this.totalPrice,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'orderItems': orderItems!.map((x) => x).toList(),
      'total_price': totalPrice,
      'phone_number': phoneNumber,
      'createdAt': paidAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      orderItems: map['orderItems'] != null
          ? List<OrderItem>.from(
              (map['orderItems']).map<OrderItem?>(
                (x) => OrderItem.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      totalPrice: map['total_price'] != null ? map['total_price'] as num : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
      paidAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, user: $user, orderItems: $orderItems, totalPrice: $totalPrice, phoneNumber: $phoneNumber, paidAt: $paidAt)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        listEquals(other.orderItems, orderItems) &&
        other.totalPrice == totalPrice &&
        other.phoneNumber == phoneNumber &&
        other.paidAt == paidAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        orderItems.hashCode ^
        totalPrice.hashCode ^
        phoneNumber.hashCode ^
        paidAt.hashCode;
  }
}

class OrderItem {
  String? name;
  int? qty;
  String? image;
  num? price;
  String? product;

  OrderItem({this.name, this.qty, this.image, this.price, this.product});

  factory OrderItem.fromJson(Map<String, dynamic> res) {
    return OrderItem(
      name: res['name'],
      qty: res['qty'],
      image: res['image'],
      price: res['price'],
      product: res['product'],
    );
  }
}
