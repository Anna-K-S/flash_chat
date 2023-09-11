import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/service/firebase.dart';
import 'package:flash_chat/styles/chat_style.dart';
import 'package:flutter/material.dart';

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    //StreamBuilder для прослушивания изменений в коллекции Firebase
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseService.firestore
            .collection(
              'messages',
              //сортировка сообщений по полю 'timestamp' в порядке убывания
            ).orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //блок проверяет есть ли в snapshot данные и находится ли поток в состоянии ожидания
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              //если данных нет и поток в состоянии ожидания отображается индикатор загрузки
              child: CircularProgressIndicator(),
            );
          }
          //если в snapshot есть данные 
          if (snapshot.hasData) {
            //получаются сообщения из snapshot и переворачиваются 
            var messages = snapshot.data!.docs.reversed;

            //создание списков messageStyles для хранения стилей сообщений
            // и currentUser для хранения адреса электронной почты текущего пользователя
            final List<ChatScreenStyle> messageStyles = [];
            final currentUser = FirebaseService.loggedInUser?.email;

            for (var message in messages) {
              final text = message.get('text');
              final sender = message.get('sender') as String;
              final timestamp = message.get('timestamp');

              //для каждого сообщения создается экземпляр ChatScreenStyle
              //хранит информацию о тексте сообщения, отправителе, времени отправки и было ли отправлено сообщение текущим пользователем
              final messageStyle = ChatScreenStyle(
                message: text,
                sender: sender,
                authorizedUser: currentUser == sender,
                timestamp: timestamp,
                
              );

              //добавление созданного стиля в список messageStyles
              messageStyles.add(messageStyle);
            }

            if (snapshot.hasError) {
              return Center(
                //отображение сообщения об ошибке
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Expanded(
              //отображение сообщений в порядке убывания
              child: ListView(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                children: messageStyles.reversed.toList(),
              ),
            );
          }
          return Container();
        });
  }
}
