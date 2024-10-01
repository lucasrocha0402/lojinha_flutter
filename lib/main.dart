import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Menu',
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomeScreen(),
        routes: {
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}
