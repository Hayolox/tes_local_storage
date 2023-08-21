import 'package:to_do_list/data/model/time_model.dart';
import 'package:to_do_list/data/provider/api_provider.dart';

import '../model/to_do_model.dart';
import '../provider/db_to_do_provider.dart';

class ToDoRepository {
  final DBProvider dbProvider = DBProvider();
  final ApiProvider api = ApiProvider();

  Future<List<ToDoModel>> getAllTodos() async {
    final List<Map<String, dynamic>> maps = await dbProvider.getAllTodos();

    return List.generate(
      maps.length,
      (index) {
        return ToDoModel(
          id: maps[index]['id'],
          title: maps[index]['title'],
          description: maps[index]['description'],
        );
      },
    );
  }

  Future<void> addTodo(ToDoModel todo) async {
    await dbProvider.insert(todo);
  }

  Future<void> updateTodo(ToDoModel todo) async {
    await dbProvider.update(todo);
  }

  Future<void> deleteTodo(int id) async {
    await dbProvider.delete(id);
  }

  Future<void> reorderTodos(List<ToDoModel> todos) async {
    return dbProvider.reorderTodos(todos);
  }

  Future<TimeModel> getTime() async {
    TimeModel time = TimeModel.fromJson(await api.getTime());
    return time;
  }
}
