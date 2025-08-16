import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/presentation/blocs/auth_cubit.dart';
import '../../features/auth/presentation/repo/auth_repo.dart';


final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  sl.registerFactory(() => AuthCubit(sl()));
}
