import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart'; // Importar o provider do carrinho

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: '1',
      title: 'Coca cola lata 350ml',
      description: 'Descrição do Produto 1',
      price: 5.59,
      imageUrl:
          'https://www.shutterstock.com/image-photo/zaporizhzhia-ukraine-march-19-2023-600nw-2284250245.jpg',
    ),
    Product(
      id: '2',
      title: 'Batata frita M',
      description: 'Descrição do Produto 2',
      price: 5.59,
      imageUrl:
          'https://cdn.awsli.com.br/1802/1802445/produto/2092821035b63f61a6e.jpg',
    ),
  ];

  void _showQuantityDialog(BuildContext context, Product product) {
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Escolha a quantidade'),
          content: TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Quantidade'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final quantity = int.tryParse(quantityController.text) ?? 1;
                if (quantity > 0) {
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(product.title, product.price, quantity);
                }
                Navigator.of(ctx).pop();
              },
              child: Text('Adicionar ao Carrinho'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loja Virtual'),
        backgroundColor: Colors.green, // Cor de fundo verde
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrinho'),
              onTap: () {
                Navigator.pushNamed(context, '/cart'); // Navega para o carrinho
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green[100], // Cor verde clara
            elevation: 5,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      products[index].imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        products[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${products[index].price.toStringAsFixed(2)}'),
                      ElevatedButton(
                        onPressed: () {
                          _showQuantityDialog(context, products[index]);
                        },
                        child: Text('Adicionar ao Carrinho'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
