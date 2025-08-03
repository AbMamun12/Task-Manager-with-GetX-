import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/controller/forgot_password_otp_Controller.dart';
import 'package:task_manager/ui/screens/recovery_password_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_massage.dart';

import '../widgets/task_widgets.dart';

class ForgotPasswordOtpVerification extends StatefulWidget {
  final String gmail;
  const ForgotPasswordOtpVerification({
    super.key,
    required this.gmail,
  });

  static const String name = '/Forgot-Password/OTP-Verification';

  @override
  State<ForgotPasswordOtpVerification> createState() =>
      _ForgotPasswordOtpVerificationState();
}

class _ForgotPasswordOtpVerificationState
    extends State<ForgotPasswordOtpVerification> {
  final TextEditingController _otpTEController = TextEditingController();

  final ForgotPasswordOtpController _forgotPasswordOtpController =
      Get.find<ForgotPasswordOtpController>();
  int otpLength = 0;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 96),
                Text(
                  'PIN Verification',
                  style: textThem.headlineMedium,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: textThem.bodyMedium,
                ),
                SizedBox(height: 24),
                _buildPinCodeTextField(),
                SizedBox(height: 24),
                GetBuilder<ForgotPasswordOtpController>(builder: (controller) {
                  return ElevatedButton(
                    onPressed:
                        controller.inProgress == true ? _otpVerifyButton : null,
                    child: controller.inProgress == true
                        ? Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Colors.white,
                            size: 24,
                          )
                        : CircularProgressIndicator(
                            color: AppColors.themColor,
                          ),
                  );
                }),
                SizedBox(height: 36),
                Center(
                  child: buildSignUpSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
      onChanged: (value) {
        otpLength = value.length;
      },
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

  void _otpVerifyButton() {
    if (otpLength == 6) {
      _otpVerify();
    }
  }

  Future<void> _otpVerify() async {
    final String otp = _otpTEController.text.trim();
    final String gmail = widget.gmail;

    final Map gmailAndOtp = {'gmail': gmail, 'otp': otp};
    bool isSuccess = await _forgotPasswordOtpController.verifyOtp(gmail, otp);

    if (isSuccess) {
      Get.offNamed(RecoveryPasswordScreen.name, arguments: gmailAndOtp);
      _otpTEController.clear();
    } else {
      showSnackBarMessage(
          context, _forgotPasswordOtpController.errorMessage, false);
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
