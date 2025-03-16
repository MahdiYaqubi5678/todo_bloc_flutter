import 'package:isar/isar.dart';
import 'package:todo_bloc/data/model/isar_todo.dart';
import 'package:todo_bloc/domain/model/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  // database
  final Isar db;

  IsarTodoRepo(this.db);

  // get todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch from db
    final todos = await db.todoIsars.where().findAll();

    // return as a list of todos and give to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // add todos
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert the todo into a isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // so that we can store it in our database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // update todos
  @override
  Future<void> updateTodo(Todo todo) {
    // convert the todo into a isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    // so that we can store it in our database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // delete todos
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
