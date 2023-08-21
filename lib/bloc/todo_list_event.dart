// data/blocs/todo_event.dart

import '../data/model/to_do_model.dart';

abstract class TodoListEvent {}

class LoadTodos extends TodoListEvent {}

class GetDataTodoList extends TodoListEvent {}

class AddTodo extends TodoListEvent {
  final String title;
  final String description;

  AddTodo(this.title, this.description);
}

class UpdateTodo extends TodoListEvent {
  final int id;
  final String title;
  final String description;

  UpdateTodo(this.id, this.title, this.description);
}

class DeleteTodo extends TodoListEvent {
  final int id;

  DeleteTodo(this.id);
}

class ReorderTodos extends TodoListEvent {
  final List<ToDoModel> todos;

  ReorderTodos(this.todos);
}
