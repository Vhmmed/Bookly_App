import 'package:bloc/bloc.dart';
import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/repo/home_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepo homeRepo;

  SearchCubit(this.homeRepo) : super(SearchInitial());

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await homeRepo.fetchSearchBooks(query);

    result.fold(
          (failure) => emit(SearchFailure(failure)),
          (books) => emit(SearchSuccess(books: books)),
    );
  }
}