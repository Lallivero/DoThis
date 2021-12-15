import 'package:do_this/provider/my_provider.dart';
import 'package:do_this/widgets/document_widget.dart';
import 'package:do_this/widgets/documents_grid.dart';
import 'package:do_this/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_screen.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DoThis'),
        backgroundColor: Colors.tealAccent,
      ),
      floatingActionButton: FAB(
        targetScreen: AddScreen(
          onPressed: (value) {
            if (value != null) {
              context.read<MyProvider>().addDocument(value);
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: DocumentsGrid()),
    );
  }
}
