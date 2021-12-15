import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {required this.isChecked,
      required this.taskTitle,
      required this.checkboxCallback,
      required this.onLongPress});
  final Function() onLongPress;
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkboxCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      onLongPress: onLongPress,
    );
  }
}
