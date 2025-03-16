import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/model/todo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoVeiw extends StatelessWidget {
  const TodoVeiw({super.key});

  // show dialog box to user type
  void _showAddToBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textControlller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textControlller,
        ),
        actions: [
          // cancel
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),

          // save
          TextButton(
            onPressed: () {
              todoCubit.addTodos(textControlller.text);

              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // tod cubit
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      // FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddToBox(context),
        child: const Icon(Icons.add),
      ),

      // BODY
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          // listVeiw
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todos list
              final todo = todos[index];

              // list tile
              return ListTile(
                // text
                title: Text(todo.text),

                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),

                // delete
                trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodos(todo),
                  icon: const Icon(Icons.cancel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
