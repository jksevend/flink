import 'package:flink/model/collection.dart';
import 'package:flink/model/todo.dart';
import 'package:flink/service/core/sqlite_service.dart';
import 'package:flink/service/model/todo_service.dart';
import 'package:sqflite/sqflite.dart';

class CollectionService {
  final Database _database;

  static final CollectionService _instance = CollectionService._internal();

  CollectionService._internal() : _database = SqliteService.instance.database;

  factory CollectionService() => _instance;

  /// Read a single [Collection] by it's [id] parameter.
  ///
  /// If no collection is found return null.
  Future<Collection?> readById(final String id) async {
    final List<Map<String, dynamic>> collectionRecords =
        await _database.rawQuery('select * from tab_todo where id = ?', [id]);

    if (collectionRecords.isEmpty) return null;

    final Map<String, dynamic> collectionRecord = collectionRecords.first;
    final List<Todo> todos = await TodoService().readAllByCollectionId(collectionRecord['id']);

    return Collection.fromDatabaseEntry(collectionRecord,
        todos: todos.map((todo) => todo.id).toList());
  }

  /// Read all entries from the [Collection] table
  Future<List<Collection>> readAll() async {
    final List<Map<String, dynamic>> collectionRecords =
        await _database.rawQuery('select * from tab_todo');

    if (collectionRecords.isEmpty) return [];

    final List<Collection> collections = [];
    for (var record in collectionRecords) {
      final List<Todo> todos = await TodoService().readAllByCollectionId(record['id']);

      final Collection collection =
          Collection.fromDatabaseEntry(record, todos: todos.map((todo) => todo.id).toList());
      collections.add(collection);
    }

    return collections;
  }

  /// Insert a new [Collection]
  Future<void> insert(final Collection collection) async {
    await _database.rawInsert(
        'insert into tab_collection (id, name, description, created_at, updated_at) values(?, ?, ?, ?, ?)',
        [
          collection.id,
          collection.name,
          collection.description,
          collection.createdAt.toIso8601String(),
          collection.updatedAt.toIso8601String(),
        ]);
  }

  /// Deletes a [Collection] entry by it's [id]
  Future<void> delete(final String id) async {
    await _database.rawDelete('delete from tab collection where id = ?', [id]);
  }
}
