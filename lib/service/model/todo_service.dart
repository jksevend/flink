import 'package:flink/model/todo.dart';
import 'package:flink/service/core/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

class TodoService {
  final Database _database;

  static final TodoService _instance = TodoService._internal();

  TodoService._internal() : _database = SqliteService.instance.database;

  factory TodoService() => _instance;

  /// Reads a [Todo] by it's [id]
  Future<Todo?> readById(final String id) async {
    final List<Map<String, dynamic>> todoRecords =
        await _database.rawQuery('select * from tab_todo where id = ?', [id]);

    if (todoRecords.isEmpty) {
      return null;
    }

    final Map<String, dynamic> todoEntry = todoRecords.first;
    return Todo.fromDatabaseEntry(todoEntry);
  }

  /// Read all entries from the [Todo] table
  Future<List<Todo>> readAll() async {
    final List<Map<String, dynamic>> todoRecords =
        await _database.rawQuery('select * from tab_todo');
    if (todoRecords.isEmpty) {
      return [];
    }
    return todoRecords.map((entry) => Todo.fromDatabaseEntry(entry)).toList();
  }

  /// Read all [Todo] where [Todo.favourite] is true
  Future<List<Todo>> readFavourites() async {
    final List<Map<String, dynamic>> todoRecords =
    await _database.rawQuery('select * from tab_todo where favourite = 1');
    if (todoRecords.isEmpty) {
      return [];
    }
    return todoRecords.map((entry) => Todo.fromDatabaseEntry(entry)).toList();
  }

  /// Read all entries from the [Todo] table which match the collection [id]
  Future<List<Todo>> readAllByCollectionId(final String id) async {
    final List<Map<String, dynamic>> todoRecords =
        await _database.rawQuery('select * from tab_todo where collection_id = ?', [id]);
    if (todoRecords.isEmpty) {
      return [];
    }
    return todoRecords.map((entry) => Todo.fromDatabaseEntry(entry)).toList();
  }

  /// Insert a new [Todo]
  Future<void> insert(final Todo todo) async {
    await _database.rawInsert(
        'insert into tab_todo (id, collection_id, title, content, deadline, remind_at, done, favourite, created_at, updated_at)'
        ' values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          todo.id,
          todo.collection ?? 'NULL',
          todo.title,
          todo.content ?? 'NULL',
          todo.deadline?.toIso8601String() ?? 'NULL',
          todo.remindAt?.toIso8601String() ?? 'NULL',
          todo.done == true ? 1 : 0,
          todo.favourite == true ? 1 : 0,
          todo.createdAt.toIso8601String(),
          todo.updatedAt.toIso8601String(),
        ]);
  }

  /// Delete a [Todo] by it's [id]
  Future<void> delete(final String id) async {
    await _database.rawDelete('delete from tab_todo where id = ?', [id]);
  }

  /// Update the [collectionId] column for each todo contained in [todoIds]
  Future<void> updateCollectionForTodos(String collectionId, final List<String> todoIds) async {
    for (var todoId in todoIds) {
      await _database
          .rawUpdate('update tab_todo set collection_id = ? where id = ?', [collectionId, todoId]);
    }
  }
}
