import 'package:flash_chat/service/message_service.dart';
import 'package:flash_chat/service/user_service.dart';
import 'package:flash_chat/widgets/user_message.dart';
import 'package:flutter/material.dart';

class UserMessagesWidget extends StatelessWidget {
  const UserMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //StreamBuilder для прослушивания изменений в коллекции Firebase
    return StreamBuilder<List<UserMessage>>(
        stream: MessagesService().stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserMessage>> snapshot) {
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
            var messages = snapshot.data!;

            final currentUser = UserService().currentUser?.email;

            if (snapshot.hasError) {
              return Center(
                //отображение сообщения об ошибке
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Expanded(
              //отображение сообщений в порядке убывания
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                itemCount: messages.length,
                //для каждого сообщения создается экземпляр UserMessageWidget
                //хранит информацию о тексте сообщения, отправителе, времени отправки и было ли отправлено сообщение текущим пользователем
                itemBuilder: (context, index) => UserMessageWidget(
                  message: messages[index],
                  authorizedUser: currentUser == messages[index].sender,
                ),
              ),
            );
          }
          return Container();
        });
  }
}
