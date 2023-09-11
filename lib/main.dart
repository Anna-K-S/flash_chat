import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const FlashChat(),
  );
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/welcome',
        onGenerateRoute: (settings) => switch (settings.name) {
              '/welcome' => MaterialPageRoute(
                  builder: (_) => WelcomeScreen(
                    name: settings.arguments.toString(),
                  ),
                ),
              '/login' => MaterialPageRoute(
                  builder: (_) => LoginScreen(
                    name: settings.arguments as String,
                  ),
                ),
              '/registration' => MaterialPageRoute(
                  builder: (_) => RegistrationScreen(
                    name: settings.arguments.toString(),
                  ),
                ),
              '/chat' => MaterialPageRoute(
                  builder: (_) =>
                      ChatScreen(name: settings.arguments.toString()),
                ),
              '/resetPassword' => MaterialPageRoute(
                  builder: (_) => ResetPasswordScreen(
                    name: settings.arguments.toString(),
                  ),
                ),
              _ => null
            });
  }
}
