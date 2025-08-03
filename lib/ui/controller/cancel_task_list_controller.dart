import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_by_status_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../../data/utils/urls.dart';
import '../utils/status.dart';

class CancelTaskListController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  TaskListByStatusModel? _taskListByStatusModel;
  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  List<TaskModel>? get taskListModel => _taskListByStatusModel?.taskList;

  Future<bool> getList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.taskListByStatusUrl(Status.Cancel));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = '';
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
    } else {
      isSuccess = false;
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void deleteItem(int index) {
    taskListModel?.removeAt(index);
    update();
  }
}
