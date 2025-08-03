import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';

import 'package:task_manager/data/utils/urls.dart';

class ProfileUpdateController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> profileUpdate(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;
    _inProgress = true;
    update();


    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
