import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_list_bloc.dart';
import '../bloc/todo_list_state.dart';
import '../bloc/todo_list_event.dart';

class EditDataPage extends StatelessWidget {
  final String title;
  final String description;
  final int id;

  const EditDataPage({
    required this.title,
    required this.description,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController descriptionController =
        TextEditingController(text: description);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
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
              controller: titleController,
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
              controller: descriptionController,
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
                      Text('Updating Data...'),
                    ],
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Title and Description cannot be empty'),
                          ),
                        );
                      } else {
                        final todoListBloc =
                            BlocProvider.of<TodoListBloc>(context);
                        todoListBloc.add(UpdateTodo(id, titleController.text,
                            descriptionController.text));
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      }
                    },
                    child: const Text('Save Changes'),
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
