import 'package:assignment_1/views/widgets/smart_indicator.dart';
import 'package:flutter/material.dart';
import 'package:assignment_1/models/dummy_json_models.dart';

class ProductBannerWidget extends StatelessWidget {
  const ProductBannerWidget({
    super.key,
    required this.product,
    this.onPressed,
    this.currentIndex,
    this.totalItems,
  });

  final Product product;
  final VoidCallback? onPressed;
  final int? currentIndex;
  final int? totalItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Colors.purple.shade300,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Stack(
        children: [
          // CIRCLE EFFECT
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -40,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // LEFT SIDE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TAG
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // TITLE
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // DESCRIPTION
                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // BUTTON
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        onPressed: onPressed,
                        child: const Text(
                          "Shop Now",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // RIGHT IMAGE
                Hero(
                  tag: product.id,
                  child: Image.network(
                    product.thumbnail,
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Center(
              child: SmartIndicator(
                currentIndex: currentIndex!,
                totalItems: totalItems!,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 15,
            child: Text(
              '${currentIndex! + 1} \\ $totalItems',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
