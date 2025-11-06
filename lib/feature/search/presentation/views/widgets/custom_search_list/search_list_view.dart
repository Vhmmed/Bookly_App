import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import 'package:flutter/material.dart';

import '../custom_best_seller_search_list/custom_best_seller.dart';


class SearchResultListView extends StatelessWidget {
  final BookModel bookModel;

  const SearchResultListView({super.key , required this.bookModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: CustomBestSeller(
            bookModel: bookModel,
          ),
        );
      }, itemCount: 5,
    );
  }
}