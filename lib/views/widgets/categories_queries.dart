import 'package:assignment_1/views/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CategoriesQueries extends StatefulWidget {
  const CategoriesQueries({
    super.key,
    required this.categories,
    this.onSelected,
  });

  final List<String> categories;
  final Function(String)? onSelected;

  @override
  State<CategoriesQueries> createState() => _CategoriesQueriesState();
}

int selectedIndex = 0;

class _CategoriesQueriesState extends State<CategoriesQueries> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              /// CATEGORY QUERY
              widget.onSelected!(categories[index]);
            },

            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),

              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainer,

                borderRadius: BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Theme.of(context).colorScheme.shadow,
                    offset: Offset(0, 3),
                  ),
                ],
              ),

              child: Center(
                child: Text(
                  widget.categories[index],

                  style: TextStyle(
                    color: isSelected || isDark
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },

        separatorBuilder: (_, _) => const SizedBox(width: 12),

        itemCount: widget.categories.length,
      ),
    );
  }
}
