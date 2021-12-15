import 'package:do_this/provider/my_provider.dart';
import 'package:do_this/screens/tasks_screen.dart';
import 'package:do_this/widgets/document_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentsGrid extends StatelessWidget {
  const DocumentsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            final document = provider.documents[index];
            return DocumentWidget(
              name: document.name!,
              onLongPress: () {
                provider.removeDocument(document.id!);
              },
              onTap: () {
                provider.activeDocumentId = document.id;
                provider.activeDocumentName = document.name;
                provider.loadTasks(provider.activeDocumentId!);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TasksScreen()),
                );
              },
            );
          },
          itemCount: provider.documents.length,
        );
      },
    );
  }
}
