import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Ui/controllers/new_task_list_controller.dart';
import 'package:task_manager/Ui/screens/Bottom_navigation_bar/add_new_task_screen.dart';
import 'package:task_manager/Ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/Ui/widgets/snack_bar_message.dart';
import 'package:task_manager/Ui/widgets/task_card.dart';
import 'package:task_manager/Ui/widgets/task_summary_card.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/models/task_status_count_model.dart';
import 'package:task_manager/data/models/task_status_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountListInProgress = false;
  List<TaskStatusModel> _taskStatusCountList = [];

  final NewTaskListController _newTaskListController = Get.find<NewTaskListController>();


  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: GetBuilder<NewTaskListController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ListView.separated(
                      itemCount: controller.taskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskModel: controller.taskList[index],
                          onRefreshList: _getNewTaskList,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddFAB,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: _getTaskStatusCountListInProgress==false,
        replacement: const CenteredCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _getTaskSummaryCardList() ,
          ),
        ),
      ),
    );
  }

  List<TaskSummaryCard> _getTaskSummaryCardList() {
    List<TaskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList.add(
        TaskSummaryCard(
          title: t.sId ?? '',
          count: t.sum ?? 0,
          backgroundColor: _getColorForStatus(t.sId ?? ''),
        ),
      );
    }
    return taskSummaryCardList;
  }
  Color _getColorForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blueAccent;
      case 'progress':
        return Colors.purpleAccent;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }



  Future<void> _onTapAddFAB() async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
    if (result == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();

    if (result==false) {
      showSnackBarMessege(context, _newTaskListController.errorMessage!, true);
    }
  }
  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountListInProgress = false;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskStatusCount,
    );
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(
        response.responseData,
      );
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessege(context, response.errorMessage, true);
    }
    _getTaskStatusCountListInProgress = false;
    setState(() {});
  }

}
