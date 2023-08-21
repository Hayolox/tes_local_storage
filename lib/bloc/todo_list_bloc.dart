// data/blocs/todo_bloc.dart

import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/todo_list_event.dart';
import 'package:to_do_list/bloc/todo_list_state.dart';
import 'package:to_do_list/data/model/time_model.dart';

import '../data/model/to_do_model.dart';
import '../data/repositories/to_do_repo.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final ToDoRepository toDoRepository;

  TodoListBloc({required this.toDoRepository}) : super(TodoInitial()) {
    Future.delayed(Duration.zero, () {
      add(GetDataTodoList());
    });

    on<GetDataTodoList>(
      (event, emit) async {
        try {
          emit(
            TodoListLoading(),
          );
          final todos = await toDoRepository.getAllTodos();
          TimeModel time = await toDoRepository.getTime();
          emit(TodoListLoaded(todos, time));
        } catch (e) {
          emit(TodoListError('Failed to load todos: $e'));
        }
      },
    );

    on<AddTodo>(
      (event, emit) async {
        try {
          emit(
            TodoListLoading(),
          );
          final random = Random();
          final id = random.nextInt(200);
          final newTodo = ToDoModel(
              title: event.title, description: event.description, id: id);
          toDoRepository.addTodo(newTodo);
          add(GetDataTodoList());
        } catch (e) {
          emit(TodoListError('Failed to load todos: $e'));
        }
      },
    );

    on<UpdateTodo>(
      (event, emit) async {
        try {
          emit(
            TodoListLoading(),
          );
          final updatedTodo = ToDoModel(
              id: event.id, title: event.title, description: event.description);
          await toDoRepository.updateTodo(updatedTodo);
          add(GetDataTodoList());
        } catch (e) {
          emit(TodoListError('Failed to load todos: $e'));
        }
      },
    );

    on<DeleteTodo>(
      (event, emit) async {
        try {
          emit(
            TodoListLoading(),
          );
          await toDoRepository.deleteTodo(event.id);
          add(GetDataTodoList());
        } catch (e) {
          emit(TodoListError('Failed to load todos: $e'));
        }
      },
    );

    on<ReorderTodos>(
      (event, emit) async {
        try {
          await toDoRepository.reorderTodos(event.todos);
          TimeModel time = await toDoRepository.getTime();
          emit(TodoListLoaded(event.todos, time));
        } catch (e) {
          emit(TodoListError('Failed to load todos: $e'));
        }
      },
    );
  }
}
