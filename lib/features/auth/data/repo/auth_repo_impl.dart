
import '../../presentation/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<User> login(String email, String password) async {
    return User( fullName: 'Ahmed maher  ', email: email);
  }

  @override
  Future<User> signup(String fullName, String email, String password) {
    // TODO: implement signup
    throw UnimplementedError();
  }
  
}
