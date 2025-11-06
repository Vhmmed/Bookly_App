import 'package:bloc/bloc.dart';
import 'package:bookly_app/feature/home/data/model/book_model/book_model.dart';
import 'package:bookly_app/feature/home/manager/cart_cubit/cart_state.dart';
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial()) {
    _loadCart();
  }

  final List<BookModel> _cartItems = [];
  static const double _bookPrice = 19.99;

  List<BookModel> get cartItems => List.unmodifiable(_cartItems);
  int get cartItemsCount => _cartItems.length;
  double get totalPrice => _cartItems.length * _bookPrice;

  void _loadCart() {
    emit(const CartLoading());
    _updateCartState();
  }

  void addToCart(BookModel book) {
    try {
      if (_cartItems.any((item) => item.id == book.id)) {
        emit(CartError('"${book.volumeInfo.title ?? "Book"}" is already in your cart'));
        return;
      }

      _cartItems.add(book);
      _updateCartState();

      emit(CartLoaded(
        cartItems: List.unmodifiable(_cartItems),
        totalPrice: totalPrice,
        totalItems: cartItemsCount,
      ));

    } catch (e) {
      emit(CartError('Failed to add book to cart: $e'));
    }
  }

  void removeFromCart(String bookId) {
    try {
      _cartItems.removeWhere((item) => item.id == bookId);
      _updateCartState();
    } catch (e) {
      emit(CartError('Failed to remove book from cart: $e'));
    }
  }

  void removeFromCartByIndex(int index) {
    try {
      if (index >= 0 && index < _cartItems.length) {
        final removedBook = _cartItems[index];
        _cartItems.removeAt(index);
        _updateCartState();

      }
    } catch (e) {
      emit(CartError('Failed to remove book from cart: $e'));
    }
  }

  void clearCart() {
    try {
      _cartItems.clear();
      _updateCartState();
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  bool isInCart(BookModel book) {
    return _cartItems.any((item) => item.id == book.id);
  }

  bool isInCartById(String bookId) {
    return _cartItems.any((item) => item.id == bookId);
  }

  int getBookQuantity(String bookId) {
    return _cartItems.where((item) => item.id == bookId).length;
  }

  void _updateCartState() {
    emit(CartLoaded(
      cartItems: List.unmodifiable(_cartItems),
      totalPrice: totalPrice,
      totalItems: cartItemsCount,
    ));
  }

  double _calculateTotalPrice() {
    return _cartItems.length * _bookPrice;
  }

  Map<String, dynamic> getCartSummary() {
    return {
      'totalItems': cartItemsCount,
      'totalPrice': totalPrice,
      'items': _cartItems.map((book) => book.volumeInfo?.title).toList(),
    };
  }

  bool get isCartEmpty => _cartItems.isEmpty;

  void toggleCartItem(BookModel book) {
    if (isInCart(book)) {
      removeFromCart(book.id!);
    } else {
      addToCart(book);
    }
  }

  Stream<int> get cartItemsCountStream async* {
    yield cartItemsCount;
    yield* stream.map((state) {
      if (state is CartLoaded) {
        return state.totalItems;
      }
      return 0;
    });
  }
}