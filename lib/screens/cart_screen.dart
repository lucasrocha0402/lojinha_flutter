import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor: Colors.green, // Cor de fundo verde
      ),
      body: cart.cartItems.isEmpty
          ? Center(child: Text('Seu carrinho está vazio!'))
          : ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (ctx, index) {
                final item = cart.cartItems[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('Quantidade: ${item.quantity}'),
                  trailing: Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
