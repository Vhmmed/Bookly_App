import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../manager/free_books_cubit/all_freebooks_cubit.dart';
import '../../../../manager/free_books_cubit/all_freebooks_state.dart';
import 'package:bookly_app/core/widget/custom_error_widget.dart';

import '../bestseller_listview_item/best_seller_list_view_item.dart';

class BestsellerListview extends StatelessWidget {
  const BestsellerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFreeBooksCubit, AllFreeBooksState>(
      builder: (context, state) {
        if (state is AllFreeBooksLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllFreeBooksSuccessState) {
          if (state.books.isEmpty) {
            return const Center(child: Text('No Books Found'));
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: BestSellerListViewItem(
                  bookModel: state.books[index],
                ),
              );
            },
          );
        } else if (state is AllFreeBooksErrorState) {
          return CustomErrorWidget(message: state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
