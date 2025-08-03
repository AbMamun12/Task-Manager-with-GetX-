import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = true;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> registration(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;
    _inProgress = false;
    update();

    NetworkCaller.isSignInScreen = true;

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);

    if (response.isSuccess) {
      String status = response.responseData!['status'];
      if (status == 'fail') {
        _errorMessage = 'Already created an account using this email.';
        isSuccess = false;
      } else {
        isSuccess = true;
      }
    } else {
      _errorMessage = response.errorMessage;
      isSuccess = false;
    }

    _inProgress = true;
    update();
    return isSuccess;
  }
}
