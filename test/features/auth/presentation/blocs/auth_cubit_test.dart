import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:la8iny/core/di/service_locator.dart';
import 'package:la8iny/features/auth/data/models/user_model.dart';
import 'package:la8iny/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:la8iny/features/auth/presentation/repo/auth_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late MockAuthRepo mockAuthRepo;
  late AuthCubit authCubit;
  setUp(() {
    mockAuthRepo = MockAuthRepo();
    authCubit = AuthCubit(mockAuthRepo);
  });
  tearDown(() {
    reset(mockAuthRepo);
  });
 group("login" , (){
   blocTest(
     'emits [ AuthStatus.Loading , AuthStatus.loaded ] when login is successful',
     build: () => authCubit,
     setUp: () {
       when(
             () => mockAuthRepo.login(any(), any()),
       ).thenAnswer((_) async => User( fullName: "fullName" , email: "email@gmail.com",));
     },
     act: (cubit) => cubit.login("email@gmail.com", "password"),
     expect:
         () => [
       AuthState(status: AuthStatus.loading),
       AuthState(
         status: AuthStatus.loaded,
         user: User( fullName: "fullName" , email: "email@gmail.com", ),
       ),
     ],
   );

   blocTest(
     'emits [ AuthStatus.Loading , AuthStatus.error ] when login is not successful',
     build: () => authCubit,
     setUp: () {
       when(
             () => mockAuthRepo.login("email@gmail.com", "password"),
       ).thenThrow(Exception("error"));
     },
     act: (cubit) => cubit.login("email@gmail.com", "password"),
     expect:
         () => [
       AuthState(status: AuthStatus.loading),
       AuthState(status: AuthStatus.error, message: "Exception: error"),
     ],
   );
 });
  group("signup" , (){

    blocTest(
      'emits [ AuthStatus.Loading , AuthStatus.loaded ] when signup is successful',
      build: () => authCubit,
      setUp: () {
        when(
              () => mockAuthRepo.signup(any(), any() , any()),
        ).thenAnswer((_) async => User( fullName: "name name " , email: "email@gmail.com", ));
      },
      act: (cubit) => cubit.signup(

        fullName: "name name ",
       email: "email@gmail.com",
        password: "password"
      ),
      expect:
          () => [
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.loaded,
          user: User(
              fullName: "name name ",
              email: "email@gmail.com", ),
        ),
      ],
    );

    blocTest(
      'emits [ AuthStatus.Loading , AuthStatus.error ] when signup is not successful',
      build: () => authCubit,
      setUp: () {
        when(() => mockAuthRepo.signup(any(), any(), any()))
            .thenThrow(Exception("This email already exists"));
      },
      act: (cubit) => cubit.signup(
        fullName: "name name ",
        email: "email@gmail.com",
        password: "password",
      ),
      expect: () => [
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.error,
          message: "This email already exists",
        ),
      ],
    );


  });
}
