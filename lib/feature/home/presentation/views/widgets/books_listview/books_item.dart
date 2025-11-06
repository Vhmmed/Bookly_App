// books_item.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BooksItem extends StatelessWidget {
  const BooksItem({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 150,
          height: 224,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: 150,
            height: 224,
            color: Colors.grey[800],
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (_, __, ___) => Container(
            width: 150,
            height: 224,
            color: Colors.grey[800],
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}