import 'package:to_do_list/data/model/time_model.dart';

import '../data/model/to_do_model.dart';

abstract class TodoListState {}

class TodoInitial extends TodoListState {}

class TodoListLoading extends TodoListState {}

class TodoListDoneLoad extends TodoListState {}

class TodoListLoaded extends TodoListState {
  final List<ToDoModel> todos;
  final TimeModel time;
  TodoListLoaded(this.todos, this.time);
}

class TodoListError extends TodoListState {
  final String errorMessage;

  TodoListError(this.errorMessage);
}
