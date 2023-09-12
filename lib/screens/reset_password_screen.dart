import 'package:flash_chat/styles/text_styles.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flash_chat/styles/decorations_styles.dart';
import 'package:flash_chat/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String name;

  const ResetPasswordScreen({
    required this.name,
    super.key,
  });

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final bool _showSpinner = false;

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
              const AppLogo(
                height: 160.0,
              ),
              const SizedBox(height: 42.0,),
              const Text(
                'Reset password',
                style: TextStyles.title,
              ),
              const SizedBox(
                height: 18.0,
              ),
               const Text(
                'Enter your email and we will send you a password reset link.',
                style: TextStyles.subtitle,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: DecorationStyles.textField.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                onPressed: () {},
                text: 'Send',
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
