import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key ,   this.mainAxisAlignment = MainAxisAlignment.center, required double ratingNum, required int ratingCount, required this.bookModel,  });

  final MainAxisAlignment mainAxisAlignment;
final BookModel bookModel;

  @override
  Widget build(BuildContext context) {
    final ratingNum = bookModel.volumeInfo.ratingsCount ?? 0;
    final ratingCount = bookModel.volumeInfo.averageRating?.toDouble() ?? 0.0;

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(Icons.star,color: Colors.amber,size: 20,),
        const SizedBox(width: 6.3,),
        Text(ratingNum.toStringAsFixed(1),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),),
        const SizedBox(width: 5,),
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Text( "($ratingCount)",style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),),
        ),
      ],
    );
  }
}
