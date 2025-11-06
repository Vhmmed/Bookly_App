import 'package:bookly_app/core/network/app_endpoint.dart';
import 'package:bookly_app/feature/home/data/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/failuer_massege/failure.dart';
import '../../../../core/network/api_service.dart';
import '../model/book_model/book_model.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl({required this.apiService});

  @override
  Future<Either<String, List<BookModel>>> fetchAllBooks() async {
    try {
      var json = await apiService.get(endPoint: AppEndPint.allBooks);

      final List items = json['items'] ?? [];
      List<BookModel> books = items.map((item) => BookModel.fromJson(item)).toList();

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e).errorMessage);
      }
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BookModel>>> fetchBestSellerBooks() async {
    try {
      var json = await apiService.get(endPoint: AppEndPint.bestSeller);

      final List items = json['items'] ?? [];
      List<BookModel> books = items.map((item) => BookModel.fromJson(item)).toList();

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e).errorMessage);
      }
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BookModel>>> fetchSimilarBooks({required String category}) async{
    try {
      var json = await apiService.get(endPoint: AppEndPint.similar);

      final List items = json['items'] ?? [];
      List<BookModel> books = items.map((item) => BookModel.fromJson(item)).toList();

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e).errorMessage);
      }
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BookModel>>> fetchSearchBooks(String query) async {
    try {
      debugPrint('=== FETCH SEARCH BOOKS: START ===');
      debugPrint('Search query: $query');

      var json = await apiService.get(
        endPoint: 'volumes',
        query: {
          'q': query,
          'filter': 'free-ebooks',
        },
      );

      debugPrint('=== FETCH SEARCH BOOKS: GOT RESPONSE ===');
      debugPrint('Response keys: ${json.keys}');

      if (json.containsKey('error')) {
        final errorMessage = json['error']['message'] ?? 'Unknown API error';
        debugPrint('=== API RETURNED ERROR: $errorMessage ===');
        return left(errorMessage);
      }

      if (json['items'] == null) {
        debugPrint('=== NO ITEMS IN RESPONSE ===');
        return left('No books found for your search');
      }

      debugPrint('=== SEARCH ITEMS COUNT: ${json['items'].length} ===');

      List<BookModel> books = [];
      for (var item in json['items']) {
        try {
          books.add(BookModel.fromJson(item));
        } catch (e) {
          debugPrint('=== ERROR PARSING SEARCH ITEM: $e ===');
        }
      }

      debugPrint('=== SUCCESSFULLY PARSED: ${books.length} search books ===');
      return right(books);
    } catch (e) {
      debugPrint('=== FETCH SEARCH BOOKS: CATCH ERROR ===');
      debugPrint('Error type: ${e.runtimeType}');
      debugPrint('Error message: $e');

      if (e is DioException) {
        debugPrint('=== DIO ERROR DETAILS ===');
        debugPrint('Dio error type: ${e.type}');
        debugPrint('Dio error message: ${e.message}');
        debugPrint('Dio response: ${e.response}');
        debugPrint('Dio response data: ${e.response?.data}');
        debugPrint('Dio response status: ${e.response?.statusCode}');

        return left(ServerFailure.fromDioError(e).errorMessage);
      }

      return left('Failed to search books: $e');
    }
  }


}