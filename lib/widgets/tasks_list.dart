import 'package:do_this/provider/my_provider.dart';
import 'package:do_this/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = provider.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              checkboxCallback: (bool? checkboxState) {
                provider.toggleDone(task.id!);
              },
              onLongPress: () {
                provider.removeTask(task.id!);
              },
            );
          },
          itemCount: provider.tasks.length,
        );
      },
    );
  }
}
