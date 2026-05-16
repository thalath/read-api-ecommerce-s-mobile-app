import 'package:flutter/material.dart';

class SmartIndicator extends StatelessWidget {
  const SmartIndicator({
    super.key,
    required this.currentIndex,
    required this.totalItems,
  });

  final int currentIndex;
  final int totalItems;
  @override
  Widget build(BuildContext context) {
    bool hasPrevious = currentIndex > 0;
    bool hasNext = currentIndex < totalItems - 1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: hasPrevious ? 1 : 0,
          child: _smallDot(),
        ),

        const SizedBox(width: 8),

        _activeDot(),

        const SizedBox(width: 8),

        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: hasNext ? 1 : 0,
          child: _smallDot(),
        ),
      ],
    );
  }

  Widget _activeDot() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 26,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _smallDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}
