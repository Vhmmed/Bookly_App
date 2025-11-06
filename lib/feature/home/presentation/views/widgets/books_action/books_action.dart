import 'package:flutter/material.dart';
import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import '../../../../../../core/widget/custom_button.dart';

class BooksAction extends StatelessWidget {
  final BookModel book;

  const BooksAction({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final price = _getBookPrice();
    final hasPreview = book.accessInfo?.viewability != 'NO_PAGES';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              text: price,
            ),
          ),
          Expanded(
            child: CustomButton(
              backgroundColor: hasPreview
                  ? const Color(0xffEF8262)
                  : Colors.grey,
              textColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              text: hasPreview ? 'Free Preview' : 'No Preview',
            ),
          ),
        ],
      ),
    );
  }

  String _getBookPrice() {
    final saleInfo = book.saleInfo;
    if (saleInfo?.saleability == 'FOR_SALE') {
      return 'For Sale';
    } else if (saleInfo?.saleability == 'FREE') {
      return 'Free';
    } else if (saleInfo?.saleability == 'NOT_FOR_SALE') {
      return 'Not for Sale';
    } else {
      return 'Price N/A';
    }
  }
}