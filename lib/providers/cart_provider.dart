import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final double price;
  int quantity;

  CartItem({required this.title, required this.price, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItem(String title, double price, int quantity) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.title == title);

    if (existingItemIndex >= 0) {
      // Se o item já estiver no carrinho, atualize a quantidade
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(title: title, price: price, quantity: quantity));
    }

    notifyListeners();
  }

  void removeItem(String title) {
    _cartItems.removeWhere((item) => item.title == title);
    notifyListeners();
  }

  int get itemCount => _cartItems.length;
}
