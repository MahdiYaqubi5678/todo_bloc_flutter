import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/data/model/isar_todo.dart';
import 'package:todo_bloc/data/repository/isar_todo_repo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get the directory path
  final dir = await getApplicationDocumentsDirectory();

  // open isar directory
  final isar = await Isar.open(
    [TodoIsarSchema],
    directory: dir.path,
  );

  // initailize the repository
  final isarTodoRepo = IsarTodoRepo(isar);

  // run app
  runApp(MyApp(
    todoRepo: isarTodoRepo,
  ));
}

class MyApp extends StatelessWidget {
  // database injection
  final TodoRepo todoRepo;

  const MyApp({
    super.key,
    required this.todoRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(
        todoRepo: todoRepo,
      ),
    );
  }
}
