import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flash_chat/styles/logo_decoration.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  final String name;

  const WelcomeScreen({super.key, required this.name});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
//SingleTickerProviderStateMixin используется для обеспечения анимации.
    with SingleTickerProviderStateMixin {
  //контроллер и анимация для цвета фона экрана
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      //длительность анимации
      duration: const Duration(seconds: 1),
      //синхронизация с '_WelcomeScreenState'
      vsync: this,
    );
    //анимация изменяющая цвет фона с begin до end
    _animation = ColorTween(
      begin: Colors.blueGrey,
      end: Colors.white,
    ).animate(
      _controller,
    );


    //запуск контроллера
    _controller.forward();

    //добавление слушателя 
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  //контроллер освобождается при завершении работы с экраном
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                LogoDecoration(
                  height: 60.0,
                ).logo,
                //для анимации текста
                AnimatedTextKit(
                  animatedTexts: [
                    //посимвольное появление текста
                    TyperAnimatedText(
                      'Flash Chat',
                      speed: const Duration(
                        milliseconds: 100,
                      ),
                      curve: Curves.bounceInOut,
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              onPressed: _login,
              text: 'Log In',
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(
              height: 16.0,
            ),
            RoundedButton(
              onPressed: _registration,
              text: 'Register',
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }

//переход на LoginScreen
  Future<void> _login() async {
    await Navigator.pushNamed(
      context,
      '/login',
      arguments: '/login',
    );
  }

//переход на RegistrationScreen
  Future<void> _registration() async {
    await Navigator.pushNamed(
      context,
      '/registration',
      arguments: '/registration',
    );
  }
}
