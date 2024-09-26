import 'package:firebase_auth/firebase_auth.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

abstract class AuthRepository {
  Future<User?> signUp(SignupModel signupModel);
  Future<User?> login(LoginModel loginModel);
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<User?> signUp(SignupModel signupModel) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signupModel.email,
        password: signupModel.password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<User?> login(LoginModel loginModel) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
