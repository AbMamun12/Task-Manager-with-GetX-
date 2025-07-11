import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Ui/screens/forgot_password_email_screen.dart';
import 'package:task_manager/Ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/Ui/screens/sign_up_screen.dart';
import 'package:task_manager/Ui/utils/app_colors.dart';
import 'package:task_manager/Ui/widgets/screen_background.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  'Get Started With',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                _buildSignInForm(),
                const SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPasswordButton,
                        child: const Text(
                          'Forget Password? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      _buildSignUpSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password')
          ,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Don't have an account? ",
        children: [
          TextSpan(
            text: 'Sign up',
            style: TextStyle(color: AppColors.themeColor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
          ),
        ],
      ),
    );
  }

  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordEmailScreen()),
    );
  }

  void _onTapNextButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainBottomNavBarScreen()),
          (_) => false,
    );  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
