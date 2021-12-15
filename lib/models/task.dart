class Task {
  final int? _id;
  final String _name;
  bool _isDone;
  final int _document;

  Task({id, required name, required isDone, required document})
      : _id = id,
        _name = name,
        _isDone = isDone,
        _document = document;

  Task copy({
    int? id,
    String? name,
    bool? isDone,
    int? document,
  }) =>
      Task(
          id: id ?? _id,
          name: name ?? _name,
          isDone: isDone ?? _isDone,
          document: document ?? _document);

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json['id'] as int?,
        name: json['name'] as String,
        isDone: json['isDone'] == 1,
        document: json['document'] as int,
      );

  Map<String, Object?> toJson() => {
        'id': _id,
        'name': _name,
        'isDone': _isDone ? 1 : 0,
        'document': _document,
      };

  void toggleDone() {
    _isDone = _isDone ? false : true;
  }

  int? get id {
    return _id;
  }

  String get name {
    return _name;
  }

  bool get isDone {
    return _isDone;
  }
}
