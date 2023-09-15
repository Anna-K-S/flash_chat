import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesService {
  MessagesService._();

  static MessagesService? _instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory MessagesService() => _instance ??= MessagesService._();

  Future<void> add(String message, String? sender, FieldValue timestamp) =>
      _firestore
          .collection(
        'messages',
      )
          .add({
        'text': message,
        'sender': sender,
        'timestamp': timestamp,
      });

  Stream<List<UserMessage>> get stream => _firestore
        .collection(
          'messages',
          //сортировка сообщений по полю 'timestamp' в порядке убывания
        )
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => UserMessage(
                  text: e.get('text'),
                  sender: e.get('sender'),
                  time: e.get('timestamp'),
                ),
              )
              .toList(),
        );
}

class UserMessage {
  final String text;
  final String sender;
  final Timestamp time;

  UserMessage({
    required this.text,
    required this.sender,
    required this.time,
  });
}