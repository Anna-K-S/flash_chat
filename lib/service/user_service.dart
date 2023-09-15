import 'package:firebase_auth/firebase_auth.dart';


class UserService {
  static UserService? _instance;

  UserService._();

  factory UserService() => _instance ??= UserService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> register(
    String username,
    String password,
  ) =>
      _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

  Future<void> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signOut() => _auth.signOut();
}


