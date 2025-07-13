import 'package:flutter/material.dart';
import 'package:task_manager/Ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/Ui/widgets/snack_bar_message.dart';
import 'package:task_manager/Ui/widgets/task_card.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskListInProgress = false;
  List<TaskModel>_completedTaskList =[];
  
  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }
  

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: CenteredCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getCompletedTaskList();
        },
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
           return  TaskCard(
             taskModel: _completedTaskList[index],
             onRefreshList: _getCompletedTaskList,
           );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskListInProgress = false;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.completedTaskList,
    );
    if (response.isSuccess){
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList??[];

    }
    else {
      showSnackBarMessege(context, response.errorMessage,true);
    }
    _getCompletedTaskListInProgress=false;
    setState(() {});
  }
}
