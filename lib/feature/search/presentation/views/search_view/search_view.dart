import 'package:bookly_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/search_view_body/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkblue,
        title: const Text('Search Books'),
      ),
      body:  const SearchViewBody(),

    );
  }
}