import 'package:dartz/dartz.dart';

import '../model/book_model/book_model.dart';

abstract class HomeRepo{

   Future< Either<String,List<BookModel>>> fetchAllBooks();
   Future< Either<String,List<BookModel>>> fetchBestSellerBooks();
   Future< Either<String,List<BookModel>>> fetchSimilarBooks({required String category});
   Future< Either<String,List<BookModel>>> fetchSearchBooks(String query);

}
