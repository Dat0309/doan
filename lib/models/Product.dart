// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String? id;
  String? name;
  num? price;
  String? image;
  num? quantity;
  Product({
    this.id,
    this.name,
    this.price,
    this.image,
    this.quantity,
  });

  Product copyWith({
    String? name,
    num? price,
    String? image,
    num? quantity,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      image: map['image'] != null ? map['image'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, price: $price, image: $image, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.price == price &&
        other.image == image &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return name.hashCode ^ price.hashCode ^ image.hashCode ^ quantity.hashCode;
  }
}
