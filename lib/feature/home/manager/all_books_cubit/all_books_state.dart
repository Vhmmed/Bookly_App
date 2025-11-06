import 'dart:ui';

import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';


abstract class AllBooksState{}

class AllBooksInitialState extends AllBooksState{}
class AllBooksLoadingState extends AllBooksState{}
class AllBooksSuccessState extends AllBooksState{
  final List<BookModel> allBooks;

  AllBooksSuccessState({required this.allBooks});

}
class AllBooksErrorState extends AllBooksState{
 final String message;
 final VoidCallback? onRetry; // <-- Add this

 AllBooksErrorState({required this.message, this.onRetry});
}