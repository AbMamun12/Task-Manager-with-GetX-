import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 🆕 for date formatting
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback onTapDelete;
  final ValueChanged<String?> onTapChangeStatus;

  TaskItemWidget({
    super.key,
    required this.taskModel,
    required this.onTapDelete,
    required this.onTapChangeStatus,
  });

  final List<String> dropdownItems = [
    'New',
    'Progress',
    'Cancel',
    'Complete',
  ];
  final List<Color> dropdownItemsColor = [
    Colors.lightBlueAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    AppColors.themColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          title: Text(
            taskModel.title ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                taskModel.description ?? '',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatDateTime(taskModel.createdDate), // 🆕 formatted date
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff3d3d3d),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: dropdownItemsColor[
                      _getStatusColorIndex(taskModel.status!)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        taskModel.status!,
                        style:
                        const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.green,
                        ),
                        items: List.generate(
                          dropdownItems.length,
                              (index) {
                            return DropdownMenuItem<String>(
                              value: dropdownItems[index],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: dropdownItemsColor[index],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Text(
                                    dropdownItems[index],
                                    style: const TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            onTapChangeStatus(value);
                          }
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: onTapDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 🆕 format date and time nicely
  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return '';
    try {
      final dateTime = DateTime.parse(dateTimeString).toLocal();
      return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  /// 🎯 Clearer function name — returns index from status
  int _getStatusColorIndex(String status) {
    switch (status) {
      case 'New':
        return 0;
      case 'Progress':
        return 1;
      case 'Cancel':
        return 2;
      case 'Complete':
        return 3;
      default:
        return 0;
    }
  }
}
