import 'package:flutter/material.dart';
import '../../widgets/bestseller_listview/bestseller_listview.dart';
import '../../widgets/books_listview/all_books_listview.dart';
import '../../widgets/custom_appbar/custom_appbar.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              const CustomAppbar(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: const AllBooksListview(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Best Seller Books',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  )
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SliverFillRemaining(
          child: BestsellerListview(),
        ),
      ],
    );
  }
}