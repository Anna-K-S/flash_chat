import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get loggedInUser {
    return _auth.currentUser;
  }

  Future<void> registerUserWithEmailAndPassword(
      String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> newDocInCollection(
      String message, String? sender, FieldValue timestamp) async {
    _firestore
        .collection(
      'messages',
    )
        .add({
      'text': message,
      'sender': sender,
      'timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> firebaseSnapshot() {
    return _firestore
        .collection(
          'messages',
          //сортировка сообщений по полю 'timestamp' в порядке убывания
        )
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
