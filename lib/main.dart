import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'feature/home/data/repo/home_repo.dart';
import 'feature/home/data/repo/home_repo_impl.dart';
import 'feature/home/manager/all_books_cubit/all_books_cubit.dart';
import 'feature/home/manager/free_books_cubit/all_freebooks_cubit.dart';
import 'feature/home/manager/for_search_cubit/search_cubit.dart';
import 'feature/home/manager/cart_cubit/all_cart_cubit.dart';
import 'core/resources/app_colors.dart';
import 'core/app_router/app_router.dart';


void main() {
  setup();

  runApp(
    Provider<HomeRepo>(create: (_) => getIt<HomeRepoImpl>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AllBooksCubit(context.read<HomeRepo>())..getAllBooks(),),
          BlocProvider(create: (context) => AllFreeBooksCubit(context.read<HomeRepo>())..getAllFreeBooks(),),
          BlocProvider(create: (context) => SearchCubit(context.read<HomeRepo>()),),
          BlocProvider(create: (context) => CartCubit(),),
        ],
        child: const BooklyApp(),
      ),
    ),
  );
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.darkblue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}