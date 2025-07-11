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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();





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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Email'),
            validator: (String? value){
              if (value?.isEmpty??true){
                return 'Enter valid Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
              controller: _firstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            decoration: InputDecoration(hintText: 'First Name'),
            validator: (String? value){
              if (value?.isEmpty??true){
                return 'Enter First Name';
              }
              return null;

            },),
          const SizedBox(height: 8),
          TextFormField(
              controller: _lastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            decoration: InputDecoration(hintText: 'Last Name'),
            validator: (String? value){
              if (value?.isEmpty??true){
                return 'Enter LastName';
              }
              return null;

            },),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: 'Mobile'),
            validator: (String? value){
              if (value?.isEmpty??true){
                return 'Enter Mobile Number';
              }
              return null;

            },
          ),
          const SizedBox(height: 8),
          TextFormField(
              controller: _passwordTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            decoration: InputDecoration(hintText: 'Password'),
            validator: (String? value){
              if (value?.isEmpty??true){
                return 'Enter Password';
              }
              return null;

            },),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _onTapNextButton,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
      
        ],
      ),
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
    if (!_formKey.currentState!.validate()){
      return ;
    }
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
