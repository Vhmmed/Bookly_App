import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/model/book_model/book_model.dart';
import '../../../../data/model/book_model/sale_info.dart';
import '../../../../manager/cart_cubit/all_cart_cubit.dart';
import '../../../../manager/cart_cubit/cart_state.dart';
import '../book_rating/book_rating.dart';

class BestSellerListViewItem extends StatelessWidget {
  const BestSellerListViewItem({super.key, required this.bookModel});

  final BookModel bookModel;

  void _addToCart(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    if (cartCubit.isInCart(bookModel)) {
      _showAlreadyInCartSnackBar(context);
    } else {
      cartCubit.addToCart(bookModel);
      _showSuccessSnackBar(context, bookModel.volumeInfo.title ?? 'Book');
    }
  }

  void _showSuccessSnackBar(BuildContext context, String bookTitle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[300]),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Added "$bookTitle" to cart',
                style: const TextStyle(fontSize: 14,color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[900],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showAlreadyInCartSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.amber[300]),
            const SizedBox(width: 8),
            const Text('Book is already in cart', style: TextStyle(fontSize: 14,color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.grey[900],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isInCart = context.read<CartCubit>().isInCart(bookModel);

        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(
              '/bookDetailsScreen',
              extra: bookModel,
            );
          },
          onLongPress: () => _addToCart(context),
          child: SizedBox(
            height: 150,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                bookModel.volumeInfo.imageLinks?.thumbnail ??
                                    'https://via.placeholder.com/100x150?text=No+Image',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (isInCart)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          bookModel.volumeInfo.title ?? 'No Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _getAuthors(bookModel.volumeInfo.authors),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Text(
                            _getPrice(bookModel.saleInfo),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => _addToCart(context),
                            icon: Icon(
                              isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                              color: isInCart ? Colors.green : Colors.white,
                              size: 24,
                            ),
                          ),
                          BookRating(
                            ratingNum: bookModel.volumeInfo.averageRating?.toDouble() ?? 0,
                            ratingCount: bookModel.volumeInfo.ratingsCount ?? 0,
                            bookModel: bookModel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getAuthors(List<String>? authors) {
    if (authors == null || authors.isEmpty) {
      return 'Unknown Author';
    }
    return authors.join(', ');
  }

  String _getPrice(SaleInfo? saleInfo) {
    if (saleInfo?.saleability == 'FOR_SALE' &&
        saleInfo?.listPrice?.amount != null) {
      return '${saleInfo!.listPrice!.amount!.toStringAsFixed(2)} €';
    }
    return 'Free';
  }
}