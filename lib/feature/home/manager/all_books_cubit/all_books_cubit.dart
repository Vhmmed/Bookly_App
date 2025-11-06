import 'package:bookly_app/feature/home/data/repo/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_books_state.dart';

class AllBooksCubit extends Cubit<AllBooksState> {
  final HomeRepo homeRepo;

  AllBooksCubit(this.homeRepo) : super(AllBooksInitialState());

  Future<void> getAllBooks() async {
    emit(AllBooksLoadingState());
    debugPrint('=== ALL BOOKS CUBIT: START FETCHING ===');

    final result = await homeRepo.fetchAllBooks();

    result.fold(
          (error) {
        debugPrint('=== ALL BOOKS CUBIT ERROR: $error ===');
        debugPrint('=== ERROR TYPE: ${error.runtimeType} ===');
        emit(AllBooksErrorState(message: error.toString()));
      },
          (books) {
        debugPrint('=== ALL BOOKS CUBIT SUCCESS ===');
        debugPrint('Books count: ${books.length}');
        if (books.isNotEmpty) {
          debugPrint('First book: ${books[0].volumeInfo.title}');
          debugPrint('First book image: ${books[0].volumeInfo.imageLinks?.thumbnail}');
        }
        emit(AllBooksSuccessState(allBooks: books));
      },
    );
  }
}