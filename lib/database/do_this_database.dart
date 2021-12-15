import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:do_this/models/document.dart';
import 'package:do_this/models/task.dart';

class DoThisDatabase {
  static final DoThisDatabase instance = DoThisDatabase._init();

  static Database? _database;

  DoThisDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('do_this_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE tasks('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL,'
        'isDone BOOLEAN NOT NULL,'
        'document INTEGER NOT NULL)');

    await db.execute('CREATE TABLE documents('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL)');
  }

  Future<Task> createTask(Task task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toJson());
    return task.copy(id: id);
  }

  Future<Document> createDocument(Document document) async {
    final db = await instance.database;
    final id = await db.insert('documents', document.toJson());
    return document.copy(id: id);
  }

  Future<Task> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Task.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found in tasks');
    }
  }

  Future<Document?> readDocument(int id) async {
    final db = await instance.database;

    final maps = await db.query('documents', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Document.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found in documents');
    }
  }

  Future<List<Document>> readAllDocuments() async {
    final db = await instance.database;
    const orderBy = 'id ASC';

    final result = await db.query('documents', orderBy: orderBy);
    return result.map((json) => Document.fromJson(json)).toList();
  }

  Future<List<Task>> readAllTasksForDocument(int id) async {
    final db = await instance.database;
    const orderBy = 'id ASC';

    final result =
        await db.query('tasks', where: 'document = ?', whereArgs: [id], orderBy: orderBy);
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> update(Task task) async {
    final db = await instance.database;
    return db.update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> removeTask(int id) async {
    final db = await instance.database;

    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeDocument(int id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'document = ?', whereArgs: [id]);
    return await db.delete('documents', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
