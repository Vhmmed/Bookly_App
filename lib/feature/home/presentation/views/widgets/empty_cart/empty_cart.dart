import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        // Animated Icon
        Icon(
          Icons.shopping_cart_outlined,
          size: 120,
          color: Colors.grey[600],
        ),
        const SizedBox(height: 24),

        // Title
        const Text(
          'Your Cart is Empty',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Subtitle
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Looks like you haven\'t added any books to your cart yet. Start exploring our collection!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Browse Button
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Go back to home or search
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.explore),
                SizedBox(width: 8),
                Text(
                  'Browse Books',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}