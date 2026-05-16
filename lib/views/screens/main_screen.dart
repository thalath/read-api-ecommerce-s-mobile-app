import 'package:app_settings/app_settings.dart';
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
  List<Product>? loadedProducts;
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
      body: _fetchingFutureAPI(),
      bottomNavigationBar: loadedProducts == null
          ? null
          : Container(
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

  Widget _fetchingFutureAPI() {
    return FutureBuilder<List<Product>?>(
      future: _dummyData,
      builder: (context, snapshot) {
        // LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ERROR
        if (snapshot.hasError) {
          return _buildNoInternetScreen();
        }

        // EMPTY
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No Products Found"),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _dummyData = _services.readProductApi();
                    });
                  },

                  icon: const Icon(Icons.refresh),
                  label: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final products = snapshot.data!;
        loadedProducts = products;

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
    );
  }

  Widget _buildNoInternetScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ICON
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 80,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 28),

            // TITLE
            Text(
              "No Internet Connection",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // DESCRIPTION
            Text(
              "Please check your mobile data or Wi-Fi settings and try again.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // RETRY BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _dummyData = _services.readProductApi();
                  });
                },

                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // SETTINGS BUTTON
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  AppSettings.openAppSettings();
                },

                icon: const Icon(Icons.settings),
                label: const Text("Open Settings"),

                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
