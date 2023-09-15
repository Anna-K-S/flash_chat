import 'package:flash_chat/service/message_service.dart';
import 'package:flash_chat/styles/text_styles.dart';
import 'package:flutter/material.dart';

class UserMessageWidget extends StatelessWidget {
  final UserMessage message;
  final bool authorizedUser;

  const UserMessageWidget({
    required this.message,
    required this.authorizedUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //в зависимости от того, является ли текущий пользователь отправителем сообщения
    //устанавливаются значения для стиля сообщений
    final alignment =
        authorizedUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = authorizedUser ? Colors.lightBlueAccent : Colors.white;
    final textColor = authorizedUser ? TextStyles.message : TextStyles.sender;

    return Padding(
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            message.sender,
            style: TextStyles.sender,
          ),
          Material(
            borderRadius: authorizedUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(
                      30.0,
                    ),
                    bottomLeft: Radius.circular(
                      30.0,
                    ),
                    bottomRight: Radius.circular(
                      30.0,
                    ),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(
                      30.0,
                    ),
                    bottomRight: Radius.circular(
                      30.0,
                    ),
                    topRight: Radius.circular(
                      30.0,
                    ),
                  ),
            elevation: 5.0,
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                message.text,
                style: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
