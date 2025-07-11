import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/sign_in_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';
import 'package:task_manager/Ui/widgets/screen_background.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Join With Us',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSignUpForm(),
                const SizedBox(height: 24),
                Center(child: _buildHaveAccountSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'First Name')),
        const SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'Last Name')),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(hintText: 'Mobile'),
        ),
        const SizedBox(height: 8),
        TextFormField(decoration: InputDecoration(hintText: 'Password')),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),

      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Have account? ",
        children: [
          TextSpan(
            text: 'Sign In',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignIn,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    // TODO: implement on tap next Button
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
}
