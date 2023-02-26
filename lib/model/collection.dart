import 'package:flink/model/timestamp.dart';
import 'package:uuid/uuid.dart';

class Collection extends Timestamp {
  final String id;
  String name;
  String? description;
  List<String> todos;

  Collection({
    required this.name,
    this.description,
    required this.todos,
  })  : id = const Uuid().v4().toString(),
        super();

  Collection._map({
    required this.id,
    required this.name,
    required this.description,
    required this.todos,
  });

  factory Collection.fromDatabaseEntry(
    final Map<String, dynamic> entry, {
    required List<String> todos,
  }) {
    final Collection collection = Collection._map(
      id: entry['id'],
      name: entry['name'],
      description: entry['description'],
      todos: todos,
    );

    collection.createdAt = DateTime.parse(entry['created_at']);
    collection.updatedAt = DateTime.parse(entry['updated_at']);

    return collection;
  }
}
