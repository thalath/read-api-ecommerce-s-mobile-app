import 'package:assignment_1/models/dummy_json_models.dart';
import 'package:assignment_1/views/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
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
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    searchController.text.trim();
    filteredProducts = widget.products;
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  // SEARCH FUNCTION
  void searchProducts(String query) {
    final results = widget.products.where((product) {
      final title = product.title.toLowerCase();
      final category = product.category.toLowerCase();
      final searchText = query.toLowerCase();

      return title.contains(searchText) || category.contains(searchText);
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        title: const Text("Search Products"),
        centerTitle: true,
      ),

      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // SEARCH BAR
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: searchProducts,
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),

                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();

                              setState(() {
                                filteredProducts = widget.products;
                              });
                            },
                            icon: const Icon(Icons.close),
                          )
                        : null,

                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,

                    contentPadding: const EdgeInsets.symmetric(vertical: 16),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // RESULT TEXT
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      "${filteredProducts.length} Results Found",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // PRODUCT LIST
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          "No Products Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];

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
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  // IMAGE
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      product.thumbnail,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  // INFO
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          product.category,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 18,
                                            ),

                                            const SizedBox(width: 4),

                                            Text(product.rating.toString()),
                                          ],
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          "\$${product.price}",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // BUTTON
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        widget.onAddToCart(product);
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
