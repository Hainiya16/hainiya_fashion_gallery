import 'package:flutter/material.dart';
import '../models/shoe_model.dart';

class CartProvider extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _cartItems = {};

  Map<String, Map<String, dynamic>> get cartItems => _cartItems;

  int get itemCount => _cartItems.length;

  double get totalAmount {
    double total = 0;
    _cartItems.forEach((key, value) {
      total += (value['shoe'] as Shoe).price * value['quantity'];
    });
    return total;
  }

  void addToCart(Shoe shoe, {String size = '9', String color = 'Black'}) {
    final id = '${shoe.id}_$size';
    if (_cartItems.containsKey(id)) {
      _cartItems[id]!['quantity']++;
    } else {
      _cartItems[id] = {
        'shoe': shoe,
        'quantity': 1,
        'size': size,
        'color': color,
      };
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    if (_cartItems.containsKey(id)) {
      if (quantity <= 0) {
        removeFromCart(id);
      } else {
        _cartItems[id]!['quantity'] = quantity;
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}