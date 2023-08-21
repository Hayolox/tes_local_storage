// data/providers/db_provider.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_list/data/model/to_do_model.dart';

class DBProvider {
  late Database _database;

  Future open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getAllTodos() async {
    await open();
    return await _database.query('todos');
  }

  Future<int> insert(ToDoModel todo) async {
    await open();
    return await _database.insert('todos', todo.toMap());
  }

  Future<int> update(ToDoModel todo) async {
    await open();
    return await _database
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    await open();
    return await _database.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> reorderTodos(List<ToDoModel> todos) async {
    await open();

    final batch = _database.batch();

    for (int i = 0; i < todos.length; i++) {
      final todo = todos[i];
      batch.update(
        'todos',
        todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
      );
    }

    await batch.commit();
  }
}
