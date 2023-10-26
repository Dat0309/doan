import 'package:doan/models/Cart.dart';
import 'package:doan/models/Product.dart';
import 'package:doan/services/repositories/cart_repo.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<String, Cart> items = {};
  List<Cart> storageItems = [];

  int get totalItems {
    var totalQuantity = 0;
    items.forEach((key, value) {
      totalQuantity += value.qty!;
    });
    update();
    return totalQuantity;
  }

  int get totalPrice {
    var price = 0;
    items.forEach((key, value) {
      price += value.price!.toInt() * value.qty!;
    });
    return price;
  }

  set setCart(List<Cart> listItems) {
    storageItems = listItems;
    for (var item in storageItems) {
      items.putIfAbsent(item.drinkId!, () => item);
    }
  }

  void updateItemQty(String id, int qty) {
    if (items.containsKey(id)) {
      items.update(
          id,
          (value) => Cart(
                name: value.name,
                drinkId: value.drinkId,
                image: value.image,
                price: value.price,
                qty: value.qty! + qty,
              ));
    }
    update();
  }

  void removeItem(Cart cart) {
    items.remove(cart.drinkId);
    cartRepo.addToCartList(getItems);
    update();
  }

  void addItem(Product product, int qty) {
    if (items.containsKey(product.id)) {
      items.update(product.id!, (value) {
        return Cart(
          name: value.name,
          drinkId: value.drinkId,
          image: value.image,
          price: value.price,
          qty: value.qty! + qty,
        );
      });
    } else {
      items.putIfAbsent(
          product.id!,
          () => Cart(
                name: product.name,
                drinkId: product.id,
                image: product.image,
                price: product.price,
                qty: qty,
              ));
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Product product) {
    if (items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  List<Cart> get getItems {
    return items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<Cart> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  void clearCart() {
    cartRepo.clearCartStorage();
    items.clear();
    update();
  }
}
