import 'package:flash_chat/service/firebase.dart';
import 'package:flash_chat/styles/text_styles.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flash_chat/styles/decorations_styles.dart';
import 'package:flash_chat/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  final String name;

  const LoginScreen({required this.name, super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  //индикатор загрузки
  late bool _showSpinner = false;

//text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  //метод 'dispose' для освобождения памяти, выделенной под переменные при удалении объекта state
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SingleChildScrollView(
                //логотип
                child: AppLogo(
                  height: 200.0,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              //поле для ввода email
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                //сохранение введенного значение в переменную email
                onChanged: (value) {
                  email = value;
                },
                decoration: DecorationStyles.textField.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              //поле для ввода пароля
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                //скрытие введенного текста в поле password
                obscureText: true,
                //сохранение введенного значения в переменную password
                onChanged: (value) {
                  password = value;
                },
                decoration: DecorationStyles.textField.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // кнопка для восстановления пароля
                  TextButton(
                    onPressed: _resetPassword,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyles.forgotPasswordButton,
                    ),
                  ),
                ],
              ),
              RoundedButton(
                onPressed: _onLogin,
                text: 'Log In',
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

//переход на следующий экран(ChatScreen)
  Future<void> _chatScreen() async {
    await Navigator.pushNamed(
      context,
      '/chat',
    );
  }

//метод для перехода на экран сброса пароля
  Future<void> _resetPassword() async {
    await Navigator.pushNamed(
      context,
      '/resetPassword',
    );
  }

  Future<void> _logIn() async {
    try {
    
      await UserService().signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      // если вход успешный, переходим в ChatScreen
      _chatScreen();
    } catch (e) {
      // ошибка входа, отображение диалогового окна с сообщением об ошибке
      _showErrorDialog('Invalid login or password. Please try again.');
    }
  }

  Future<void> _onLogin() async {
    //индикатор загрузки
    setState(() {
      _showSpinner = true;
    });

    await _logIn();

    setState(() {
      _showSpinner = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    //метод для отображения диалогового окна поверх текущего контекста
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
          ),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: _closeDialog,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}
