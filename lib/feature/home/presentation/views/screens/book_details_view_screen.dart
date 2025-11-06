import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import 'package:bookly_app/feature/home/presentation/views/widgets/book_rating/book_rating.dart';
import 'package:bookly_app/feature/home/presentation/views/widgets/books_action/books_action.dart';
import 'package:bookly_app/feature/home/presentation/views/widgets/custom_appbar_book_details/custom_book_details_appbar.dart';
import 'package:bookly_app/feature/home/presentation/views/widgets/similar_books_list_view/similar_books_list_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookDetailsViewScreen extends StatelessWidget {
  final BookModel bookModel;

  const BookDetailsViewScreen({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    final volumeInfo = bookModel.volumeInfo;
    final saleInfo = bookModel.saleInfo;

    if (volumeInfo == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No book data available',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            CustomBookDetailsAppbar(),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: volumeInfo.imageLinks?.thumbnail ?? '',
                  height: 220,
                  width: 150,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => const SizedBox(
                    height: 220,
                    width: 150,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              volumeInfo.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Opacity(
              opacity: 0.7,
              child: Text(
                (volumeInfo.authors?.isNotEmpty ?? false)
                    ? volumeInfo.authors!.join(', ')
                    : 'Unknown Author',
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            BookRating(
              ratingNum: volumeInfo.averageRating?.toDouble() ?? 0,
              ratingCount: volumeInfo.ratingsCount ?? 0,
              bookModel: bookModel,
            ),
            const SizedBox(height: 24),

            BooksAction(book: bookModel),
            const SizedBox(height: 32),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              volumeInfo.description ?? 'No description available.',
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 32),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'You May Also Like',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SimilarBooksListView(bookId: bookModel.id ?? ''),
          ],
        ),
      ),
    );
  }
}