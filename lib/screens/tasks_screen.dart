import 'package:do_this/provider/my_provider.dart';
import 'package:do_this/screens/add_screen.dart';
import 'package:do_this/widgets/fab.dart';
import 'package:do_this/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: Text(
          '${context.read<MyProvider>().activeDocumentName}',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      backgroundColor: Colors.tealAccent,
      floatingActionButton: FAB(
        targetScreen: AddScreen(
          onPressed: (value) {
            if (value != null) {
              context
                  .read<MyProvider>()
                  .addTask(value, context.read<MyProvider>().activeDocumentId!);
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: ThemeData.dark().canvasColor,
        child: TasksList(),
      ),
    );
  }
}
