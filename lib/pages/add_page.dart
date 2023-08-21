import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/bloc/todo_list_event.dart';

import '../bloc/todo_list_bloc.dart';
import '../bloc/todo_list_state.dart';

class AddDataPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        leading: IconButton(
          onPressed: () {
            context.read<TodoListBloc>().add(GetDataTodoList());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            BlocConsumer<TodoListBloc, TodoListState>(
              listener: (context, state) {
                if (state is TodoListError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TodoListLoading) {
                  return const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16.0),
                      Text('Adding Data...'),
                    ],
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.isEmpty ||
                          _descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Title and Description cannot be empty'),
                          ),
                        );
                      } else {
                        final todoListBloc =
                            BlocProvider.of<TodoListBloc>(context);
                        todoListBloc.add(
                          AddTodo(
                            _titleController.text,
                            _descriptionController.text,
                          ),
                        );
                        _titleController.clear();
                        _descriptionController.clear();
                      }
                    },
                    child: const Text('Add Data'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
