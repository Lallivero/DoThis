import 'dart:collection';

import 'package:do_this/database/do_this_database.dart';
import 'package:do_this/models/document.dart';
import 'package:do_this/models/task.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  List<Document> _documents = [];
  List<Task> _tasks = [];
  int? _activeDocumentId;
  String? _activeDocumentName;

  MyProvider() {
    _initialise();
  }

  void _initialise() async {
    _documents = await DoThisDatabase.instance.readAllDocuments();
    notifyListeners();
  }

  void loadTasks(int docId) async {
    _tasks = await DoThisDatabase.instance.readAllTasksForDocument(docId);
    notifyListeners();
  }

  Future addTask(String name, int docId) async {
    Task task = await DoThisDatabase.instance
        .createTask(Task(name: name, isDone: false, document: docId));
    _tasks.add(task);
    notifyListeners();
  }

  Future addDocument(String name) async {
    Document document =
        await DoThisDatabase.instance.createDocument(Document(name: name));
    _documents.add(document);
    print(_documents);
    notifyListeners();
  }

  void removeTask(int id) async {
    bool notDone = true;
    int i = 0;
    while (notDone) {
      if (_tasks[i].id == id) {
        _tasks.removeAt(i);
        notDone = false;
      }
      i++;
    }
    await DoThisDatabase.instance.removeTask(id);
    notifyListeners();
  }

  void removeDocument(int docId) async {
    bool notDone = true;
    int i = 0;
    while (notDone) {
      if (_documents[i].id == docId) {
        _documents.removeAt(i);
        notDone = false;
      }
      i++;
    }
    await DoThisDatabase.instance.removeDocument(docId);
    notifyListeners();
  }

  void toggleDone(int id) async {
    bool notDone = true;
    int i = 0;
    while (notDone) {
      if (_tasks[i].id == id) {
        print(_tasks[i].isDone);
        _tasks[i].toggleDone();
        print(_tasks[i].isDone);
        await DoThisDatabase.instance.update(_tasks[i]);
        notDone = false;
      }
      i++;
    }
    notifyListeners();
  }

  Future<int> numTasksForDocument(int docId) async {
    List<Task> temp = await DoThisDatabase.instance.readAllTasksForDocument(docId);
    return temp.length;
  }

  Future<Document?> getDocument(int id) async {
    return await DoThisDatabase.instance.readDocument(id);
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  UnmodifiableListView<Document> get documents {
    return UnmodifiableListView(_documents);
  }

  int? get activeDocumentId {
    return _activeDocumentId;
  }

  set activeDocumentId(int? id) {
    if (getDocument(id!) != null) {
      _activeDocumentId = id;
    }
  }

  String? get activeDocumentName {
    return _activeDocumentName;
  }

  set activeDocumentName(String? name) {
    _activeDocumentName = name;
  }
}
