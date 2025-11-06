import 'package:flutter/cupertino.dart';
import '../../data/model/book_model/book_model.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<BookModel> cartItems;
  final double totalPrice;
  final int totalItems;

  const CartLoaded({
    required this.cartItems,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartLoaded &&
        other.cartItems == cartItems &&
        other.totalPrice == totalPrice &&
        other.totalItems == totalItems;
  }

  @override
  int get hashCode => cartItems.hashCode ^ totalPrice.hashCode ^ totalItems.hashCode;
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartError &&
        other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}