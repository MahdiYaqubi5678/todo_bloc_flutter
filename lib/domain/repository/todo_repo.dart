import 'package:todo_bloc/domain/model/todo.dart';

abstract class TodoRepo {
  // GET LIST OF TODOS
  Future<List<Todo>> getTodos();

  // ADD A NEW TODOS
  Future<void> addTodo(Todo newTodo);

  // UPDATE EXISTING TODOS
  Future<void> updateTodo(Todo todo);

  // DELETE TODOS
  Future<void> deleteTodo(Todo todo);
}
