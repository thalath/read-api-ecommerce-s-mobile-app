import 'package:assignment_1/models/dummy_json_models.dart';
import 'package:assignment_1/services/dummy_json_services.dart';
import 'package:assignment_1/views/screens/cart_screen.dart';
import 'package:assignment_1/views/screens/home_screen.dart';
import 'package:assignment_1/views/screens/profile_screen.dart';
import 'package:assignment_1/views/screens/search_screen.dart';
import 'package:assignment_1/views/widgets/bttm_navbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _services = DummyJsonServices();

  late Future<List<Product>?> _dummyData;

  // CART ITEMS
  List<Product> cartItems = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _dummyData = _services.readProductApi();
  }

  void addToCartOrIncrement(Product product) {
    setState(() {
      cartItems.add(product);
    });
  }

  void removeOrDecrementFromCart(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>?>(
        future: _dummyData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("ERROR: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No Products Found"));
          }

          final products = snapshot.data!;

          // SCREENS
          final screens = [
            HomeScreen(
              products: products,
              cartItems: cartItems,
              onAddToCart: addToCartOrIncrement,
              onRemoveFromCart: removeOrDecrementFromCart,
              onIncementToCart: addToCartOrIncrement,
            ),
            SearchScreen(
              products: products,
              onAddToCart: addToCartOrIncrement,
              cartItems: cartItems,
              onRemoveFromCart: removeOrDecrementFromCart,
              onIncementToCart: addToCartOrIncrement,
            ),
            CartScreen(
              cartItems: cartItems,
              onRemoveFromCart: removeOrDecrementFromCart,
              onIncementToCart: addToCartOrIncrement,
            ),
            const ProfileScreen(),
          ];

          return IndexedStack(index: _currentIndex, children: screens);
        },
      ),

      bottomNavigationBar: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: BottomNavbarWidget(
          currentIndex: _currentIndex,

          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

          // REAL CART COUNT
          cartCount: cartItems.length,
        ),
      ),
    );
  }
}
