import 'package:flutter/material.dart';

class ProfileStat extends StatelessWidget {
  const ProfileStat({super.key, required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 4),

        Text(title, style: TextStyle(color: Colors.white.withOpacity(0.9))),
      ],
    );
  }
}
