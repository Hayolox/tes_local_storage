import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/todo_list_bloc.dart';
import '../bloc/todo_list_event.dart';
import '../bloc/todo_list_state.dart';
import 'edit_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TodoListBloc, TodoListState>(
          builder: (context, state) {
            if (state is TodoListLoaded) {
              final formattedDate =
                  DateFormat('d MMMM yyyy').format(state.time.dateTime);
              return Text('To-Do List - $formattedDate');
            } else {
              return const Text('To-Do List');
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigasi ke halaman tambah data
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: BlocBuilder<TodoListBloc, TodoListState>(
        builder: (context, state) {
          if (state is TodoListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoListLoaded) {
            if (state.todos.isEmpty) {
              return const Center(
                child: Text('Tidak ada To-Do yang tersedia.'),
              );
            } else {
              return ReorderableListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        BlocProvider.of<TodoListBloc>(context).add(
                          DeleteTodo(todo.id!),
                        );
                      }
                    },
                    child: ListTile(
                      key: Key(todo.id.toString()), // Unique key for reordering
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDataPage(
                              title: todo.title,
                              description: todo.description,
                              id: todo.id!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  final newTodos = state.todos.toList();
                  final movedTodo = newTodos.removeAt(oldIndex);
                  newTodos.insert(newIndex, movedTodo);

                  BlocProvider.of<TodoListBloc>(context).add(
                    ReorderTodos(newTodos),
                  );
                },
              );
            }
          } else if (state is TodoListError) {
            return Text('Error: ${state.errorMessage}');
          }
          return const Text('Unknown state');
        },
      ),
    );
  }
}
