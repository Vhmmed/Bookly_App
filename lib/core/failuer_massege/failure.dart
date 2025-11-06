import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: "Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "Send timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "Receive timeout with API server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: "Request to API server was cancelled");
      case DioExceptionType.unknown:
        if (dioException.message!.contains("SocketException")) {
          return ServerFailure(errorMessage: "No internet connection");
        }
        return ServerFailure(errorMessage: "Something went wrong");
        default:
        return ServerFailure(errorMessage: "Unexpected Error, Please try again later!");
    }
  }

  factory ServerFailure.fromBadResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(errorMessage: "Your request not found, please try later!");
    } else if (statusCode == 500) {
      return ServerFailure(errorMessage: "Internal server error, please try later!");
    } else {
      return ServerFailure(errorMessage: "Something went wrong");
    }
  }
}