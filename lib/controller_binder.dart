import 'package:get/get.dart';
import 'package:task_manager/Ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/Ui/controllers/sign_in_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(signInController());
    Get.put(NewTaskListController());

  }

}