import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hot_pizza/src/models/cartItem.dart';
import 'package:hot_pizza/src/utils/globalVariable.dart';

class CartBloc extends ChangeNotifier {
  CartBloc() {
    openBox();
  }
  Box _cartItemBox;
  List<dynamic> cart = new List<dynamic>();
  double total = 0;

  Future openBox() async {
    _cartItemBox = await Hive.openBox(CART_ITEM_BOX);
    return;
  }

  add(CartItemModel item) {
    _cartItemBox.put(item.id, item);
    calculateTotal();
  }

  getAllCartItem() {
    Map<dynamic, dynamic> raw = _cartItemBox != null ? _cartItemBox.toMap() : {};
    cart = raw.values.toList();
    return cart;
  }

  update(CartItemModel item) {
    int lastIndex = _cartItemBox.toMap().length - 1;
    if (lastIndex < 0) return;

    CartItemModel cartItemModel = _cartItemBox.values.toList()[lastIndex];
    _cartItemBox.putAt(lastIndex, cartItemModel);
    calculateTotal();
  }

  remove(dynamic key) {
    _cartItemBox.delete(key);
    getAllCartItem();
    calculateTotal();
  }

  increase(CartItemModel item) {
    if (item.quantity < 10) {
      item.quantity++;
      calculateTotal();
    }
  }

  decrease(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
      calculateTotal();
    }
  }

  initTotal() {
    total = 0;
    getAllCartItem().forEach((x) {
      total += (x.price * x.quantity);
    });
  }

  calculateTotal() {
    total = 0;
    getAllCartItem().forEach((x) {
      total += (x.price * x.quantity);
    });
    notifyListeners();
  }
}