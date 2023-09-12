import 'package:flash_chat/service/firebase.dart';
import 'package:flash_chat/service/messages_stream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/styles/text_styles.dart';
import 'package:flash_chat/styles/decorations_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  final String name;

  const ChatScreen({super.key, required this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //'textController' используется для управления текстовым полем ввода сообщений
  final _messageTextController = TextEditingController();

  //текс отправляемого сообщения
  late String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.close,
            ),
            onPressed: () {
              //выход пользователя из приложения
              UserService().signOut();
              //возвращение на предыдущий экран(LoginScreen)
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text(
          '⚡️Chat',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //'MessageStream' отвечает за отображение сообщений в чате
            const MessagesStream(),
            Container(
              decoration: DecorationStyles.messageContainer,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      //введенный текст из текстового поля сохраняется в переменной 'message'
                      onChanged: (value) {
                        message = value;
                      },
                      //стиль текстового поля
                      decoration: DecorationStyles.messageTextField,
                    ),
                  ),
                  //кнопка для отправки сообщения
                  TextButton(
                    onPressed: () {
                      //отчистка текстового поля после нажатия кнопки
                      _messageTextController.clear();

                      //создание нового документа в коллекции в Firestore
                      UserService().newDocInCollection(
                        message,
                        UserService().loggedInUser?.email,
                        FieldValue.serverTimestamp(),
                      );
                      // FirebaseService.firestore
                      //     .collection(
                      //   'messages',
                      // )
                      //     .add({
                      //   'text': message,
                      //   'sender': FirebaseService.loggedInUser?.email,
                      //   'timestamp': FieldValue.serverTimestamp(),
                      // });
                    },
                    child: const Text(
                      'Send',
                      style: TextStyles.sendButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
