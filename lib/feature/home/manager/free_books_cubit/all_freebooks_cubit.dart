import 'package:bookly_app/feature/home/data/repo/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'all_freebooks_state.dart';

class AllFreeBooksCubit extends Cubit<AllFreeBooksState>{

  final HomeRepo homeRepo;
  AllFreeBooksCubit(this.homeRepo) : super(AllFreeBooksInitial());

  getAllFreeBooks() async{
    emit(AllFreeBooksLoadingState());

    var result = await homeRepo.fetchAllBooks();

    result.fold((error){
      emit(AllFreeBooksErrorState(message: error ));
    }, (books){
      emit(AllFreeBooksSuccessState(books: books));
    });
  }

}