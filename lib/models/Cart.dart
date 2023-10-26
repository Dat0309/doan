class Cart {
  String? name;
  int? qty;
  String? image;
  num? price;
  String? drinkId;

  Cart({
    this.name,
    this.qty,
    this.image,
    this.price,
    this.drinkId,
  });

  factory Cart.fromJson(Map<String, dynamic> res) {
    return Cart(
      name: res['name'],
      qty: res['qty'],
      image: res['image'],
      price: res['price'],
      drinkId: res['product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product": drinkId,
      "name": name,
      "qty": qty,
      "image": image,
      "price": price,
    };
  }
}
