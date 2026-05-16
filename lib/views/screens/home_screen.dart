import 'package:assignment_1/models/dummy_json_models.dart';
import 'package:assignment_1/views/screens/detail_screen.dart';
import 'package:assignment_1/views/widgets/categories_queries.dart';
import 'package:assignment_1/views/widgets/product_baner.dart';
import 'package:assignment_1/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.products,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.onIncementToCart,
  });

  final List<Product> products;
  final List<Product> cartItems;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart;
  final Function(Product) onIncementToCart;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> categories = [
  "All",
  "beauty",
  "fragrances",
  "furniture",
  "groceries",
];

class _HomeScreenState extends State<HomeScreen> {
  List<Product> filterProduct = [];

  @override
  void initState() {
    filterProduct = widget.products;
    super.initState();
  }

  void categoryFilter(String category) {
    setState(() {
      if (category == "All") {
        filterProduct = widget.products;
      } else {
        filterProduct = widget.products.where((product) {
          return product.category.toLowerCase().contains(
            category.toLowerCase(),
          );
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(screenWidth));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text('E-Commerce'),
      actions: [
        Icon(Icons.notifications),
        Icon(Icons.light_mode_outlined),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildBody(double screenWidth) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 410, maxWidth: 1200),
        child: ListView(
          children: [
            _buildCardBanner(),
            SizedBox(height: 10),
            CategoriesQueries(
              categories: categories,
              onSelected: categoryFilter,
            ),
            _buildGridView(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildCardBanner() {
    return SizedBox(
      height: 290,
      child: PageView.builder(
        itemCount: widget.products.length,
        controller: PageController(viewportFraction: 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    product: widget.products[index],
                    cartItems: widget.cartItems,
                    onAddToCart: widget.onAddToCart,
                    onRemoveFromCart: widget.onRemoveFromCart,
                    onIncementToCart: widget.onIncementToCart,
                  ),
                ),
              );
            },
            child: ProductBannerWidget(product: widget.products[index]),
          );
        },
      ),
    );
  }

  Widget _buildGridView(double screenWidth) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: filterProduct.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth <= 768 ? 2 : 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: screenWidth <= 768 ? 0.42 : 0.52,
      ),
      itemBuilder: (context, index) {
        final Product product = filterProduct[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  product: product,
                  cartItems: widget.cartItems,
                  onAddToCart: widget.onAddToCart,
                  onRemoveFromCart: widget.onRemoveFromCart,
                  onIncementToCart: widget.onIncementToCart,
                ),
              ),
            );
          },
          child: ProductCard(
            product: product,
            onPress: () {
              widget.onAddToCart(product);
            },
          ),
        );
      },
    );
  }
}
