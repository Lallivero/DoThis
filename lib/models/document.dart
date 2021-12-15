class Document {
  final int? _id;
  final String? _name;

  Document({id, required name})
      : _id = id,
        _name = name;

  Document copy({int? id, String? name, int? numTasks}) =>
      Document(id: id ?? _id, name: name ?? _name);

  static Document fromJson(Map<String, Object?> json) =>
      Document(id: json['id'], name: json['name']);

  Map<String, Object?> toJson() => {
        'id': _id,
        'name': _name,
      };

  int? get id {
    return _id;
  }

  String? get name {
    return _name;
  }
}
