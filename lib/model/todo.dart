import 'package:flink/model/timestamp.dart';
import 'package:uuid/uuid.dart';

class Todo extends Timestamp {
  final String id;
  String title;
  String? content;
  bool done;
  DateTime? deadline;
  DateTime? remindAt;
  String? collection;

  Todo({
    required this.title,
    this.content,
    this.done = false,
    this.deadline,
    this.remindAt,
    this.collection,
  })  : id = const Uuid().v4().toString(),
        super();

  Todo._map({
    required this.id,
    required this.title,
    required this.content,
    required this.deadline,
    required this.done,
    required this.remindAt,
    required this.collection,
  });

  factory Todo.fromDatabaseEntry(final Map<String, dynamic> entry) {
    final Todo todo = Todo._map(
      id: entry['id'],
      title: entry['title'],
      content: entry['content'],
      deadline: DateTime.parse(entry['deadline']),
      done: entry['done'] == 0 ? false : true,
      remindAt: DateTime.parse(entry['remind_at']),
      collection: entry['collectionId'],
    );

    todo.createdAt = DateTime.parse(entry['created_at']);
    todo.updatedAt = DateTime.parse(entry['updated_at']);
    return todo;
  }
}
