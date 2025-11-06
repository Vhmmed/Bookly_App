import 'package:bookly_app/feature/home/data/repo/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_service.dart';

final getIt = GetIt.instance;

void setup() {

  getIt.registerSingleton<ApiService>(ApiService(dio: Dio()));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
        apiService: getIt<ApiService>(),
      )
  );

}
