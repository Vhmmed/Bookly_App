
import '../../data/model/book_model/book_model.dart';

abstract class AllFreeBooksState {}

class AllFreeBooksInitial extends AllFreeBooksState {}
class AllFreeBooksLoadingState extends AllFreeBooksState {}
class AllFreeBooksSuccessState extends AllFreeBooksState {
  final List<BookModel> books;


  AllFreeBooksSuccessState( {required this.books});
}
class AllFreeBooksErrorState extends AllFreeBooksState {
  final String message;

  AllFreeBooksErrorState({required this.message});
}
