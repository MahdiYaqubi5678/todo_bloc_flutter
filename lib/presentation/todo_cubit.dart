import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/model/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  // refrence todo repository
  final TodoRepo todoRepo;

  // constructers
  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  // L O A D
  Future<void> loadTodos() async {
    // fetch the list of todos
    final todoList = await todoRepo.getTodos();

    // emit the fetched list
    emit(todoList);
  }

  // A D D
  Future<void> addTodos(String text) async {
    // create a unique id
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );

    // save the new todo repo
    await todoRepo.addTodo(newTodo);

    // re-load
    loadTodos();
  }

  // D E L E T E
  Future<void> deleteTodos(Todo todo) async {
    // delete from repo
    await todoRepo.deleteTodo(todo);

    // re-load
    loadTodos();
  }

  // T O G G L E
  Future<void> toggleCompletion(Todo todo) async {
    // toggle the completion if provided
    final updatedTodo = todo.toggleCompletion();

    // update the todo in repo
    await todoRepo.updateTodo(updatedTodo);

    // re-load
    loadTodos();
  }
}
