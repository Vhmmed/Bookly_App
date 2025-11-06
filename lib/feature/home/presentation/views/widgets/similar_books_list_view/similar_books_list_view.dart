import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/resources/assets.dart';
import '../../../../manager/all_books_cubit/all_books_cubit.dart';
import '../../../../manager/all_books_cubit/all_books_state.dart';
import '../books_listview/books_item.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key, required bookId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBooksCubit, AllBooksState>(
      builder: (BuildContext context, state) {
        if (state is AllBooksSuccessState) {
          return SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.builder(
        itemBuilder: (context,index){
        return BooksItem(imageUrl: state.allBooks[index].volumeInfo.imageLinks?.thumbnail ?? ' ');
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: booksImages.length,),
        );
        } else if(state is AllBooksErrorState) {
          return Text(state.message);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
