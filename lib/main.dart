import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/pages/add_page.dart';
import 'package:to_do_list/pages/edit_pages.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/splashh_screen.dart';

import 'bloc/todo_list_bloc.dart';

import 'data/repositories/to_do_repo.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodoListBloc>(
          create: (context) => TodoListBloc(
            toDoRepository: ToDoRepository(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/add': (context) => AddDataPage(),
        '/edit': (context) => const EditDataPage(
              title: '',
              description: '',
              id: 0,
            ),
      },
    );
  }
}
