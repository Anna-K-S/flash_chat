import 'package:flash_chat/service/user_service.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flash_chat/styles/decorations_styles.dart';
import 'package:flash_chat/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  final String name;

  const RegistrationScreen({super.key, required this.name});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Flexible(
                child: AppLogo(
                  height: 200.0,
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              //поле для ввода данных email
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
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
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: DecorationStyles.textField.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPressed: _registerUserWithEmailAndPassword,
                color: Colors.blueAccent,
                text: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerUserWithEmailAndPassword() async {
    setState(() {
      _showSpinner = true;
    });
    //метод, который использует Firebase для создания нового юзера используя email и password
    // await FirebaseService.auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    UserService().register;

    _openChat();
    setState(() {
      _showSpinner = false;
    });
  }

//переход на следующий экран(ChatScreen)
  Future<void> _openChat() async {
    await Navigator.pushNamed(
      context,
      '/chat',
    );
  }
}
