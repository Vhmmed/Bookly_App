import 'package:bookly_app/feature/home/presentation/views/screens/book_details_view_screen.dart';
import 'package:bookly_app/feature/home/presentation/views/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../feature/home/data/model/book_model/book_model.dart';
import '../../feature/home/presentation/views/screens/cart_screen/cart_screen.dart';
import '../../feature/search/presentation/views/search_view/search_view.dart';
import '../../feature/splash/presentation/views/splash_screen.dart';

abstract class AppRouter{

  static final router = GoRouter(
    initialLocation: '/splashScreen',
      routes: [
        GoRoute(
          path: '/splashScreen',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/homeScreen',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/bookDetailsScreen',
          builder: (context, state) {
            final bookModel = state.extra as BookModel?;
            if (bookModel != null) {
              return BookDetailsViewScreen(bookModel: bookModel);
            }
            return const SizedBox.shrink();
          },
        ),
        GoRoute(
            path: '/searchScreen',
            builder: (context, state) => const SearchView(),
        ),
        GoRoute(
          path: '/cartScreen',
          builder: (context, state) => const CartScreen(),
        ),
      ]
  );

}