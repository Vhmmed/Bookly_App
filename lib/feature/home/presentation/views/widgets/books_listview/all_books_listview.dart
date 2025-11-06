import 'package:bookly_app/feature/home/manager/all_books_cubit/all_books_cubit.dart';
import 'package:bookly_app/feature/home/manager/all_books_cubit/all_books_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/custom_error_widget.dart';
import 'books_item.dart';


class AllBooksListview extends StatelessWidget {
  const AllBooksListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBooksCubit, AllBooksState>(
      builder: (BuildContext context, AllBooksState state) {
        debugPrint('=== ALL BOOKS LISTVIEW STATE: $state ===');

        if (state is AllBooksSuccessState) {
          debugPrint('=== SUCCESS: ${state.allBooks.length} books ===');
          if (state.allBooks.isEmpty) {
            return const Center(child: Text('No books found'));
          }
          return SizedBox(
            height: 224,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.allBooks.length,
              itemBuilder: (context, index) {
                final book = state.allBooks[index];
                debugPrint('Book $index: ${book.volumeInfo.title}');
                return BooksItem(
                  imageUrl: book.volumeInfo.imageLinks?.thumbnail ?? '',
                );
              },
            ),
          );
        } else if (state is AllBooksErrorState) {
          debugPrint('=== ERROR: ${state.message} ===');
          return CustomErrorWidget(
            message: state.message,
            onRetry: () {
              debugPrint('=== RETRYING ALL BOOKS ===');
              context.read<AllBooksCubit>().getAllBooks();
            },
          );
        } else {
          debugPrint('=== LOADING STATE ===');
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}