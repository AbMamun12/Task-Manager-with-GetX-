import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/recovery_password_controller.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../widgets/task_widgets.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  final Map emailAndOtp;
  const RecoveryPasswordScreen({
    super.key,
    required this.emailAndOtp,
  });

  static const String name = '/Forgot-Password/Recovery-password';

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RecoveryPasswordController _recoveryPasswordController = Get.find<RecoveryPasswordController>();

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 96),
                  Text(
                    'Set Password',
                    style: textThem.headlineMedium,
                  ),
                  Text(
                    'Minimum length password 6 character with Latter and number combination ',
                    style: textThem.bodyMedium,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                      controller: _passTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      }),
                  SizedBox(height: 12),
                  TextFormField(
                      controller: _confirmPassTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your Confirm password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      }),
                  SizedBox(height: 24),
                  GetBuilder<RecoveryPasswordController>(builder: (controller) {
                    return ElevatedButton(
                      onPressed:
                          controller.inProgress == true ? _setPassButton : null,
                      child: controller.inProgress == true
                          ? Text('Confirm')
                          : CircularProgressIndicator(
                              color: AppColors.themColor,
                            ),
                    );
                  }),
                  SizedBox(height: 48),
                  Center(
                    child: buildSignUpSection(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpSection() {
    final textThem = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        text: "Have account? ",
        style: textThem.labelLarge,
        children: [
          TextSpan(
            text: "Sign up",
            style: TextStyle(
              color: AppColors.themColor,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.back();
              },
          )
        ],
      ),
    );
  }

  void _setPassButton() {
    if (_formKey.currentState!.validate()) {
      if (_passTEController.text == _confirmPassTEController.text) {
        recoveryPassword();
      } else {
        showSnackBarMessage(context, "No Match Password", false);
      }
    }
  }

  Future<void> recoveryPassword() async {
    bool isSuccess = await _recoveryPasswordController.recoveryPass(
      widget.emailAndOtp['gmail'],
      widget.emailAndOtp['otp'],
      _confirmPassTEController.text,
    );

    if (isSuccess) {
      showSnackBarMessage(context, "Password recovery success", true);
      Future.delayed(
        Duration(seconds: 1),
        () {
          Get.offAllNamed(SignInScreen.name);
        },
      );
      _passTEController.clear();
      _confirmPassTEController.clear();
    } else {
      showSnackBarMessage(
          context, _recoveryPasswordController.errorMessage, false);
    }
  }

  @override
  void dispose() {
    _passTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }
}
