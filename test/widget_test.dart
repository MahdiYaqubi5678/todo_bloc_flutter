import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_bloc/domain/model/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';
import 'package:todo_bloc/main.dart';
import 'package:todo_bloc/presentation/todo_page.dart';

// Create a MockTodoRepo using Mockito
class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  // Initialize the binding
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoPage Widget Tests', () {
    late MockTodoRepo mockTodoRepo;

    setUp(() {
      mockTodoRepo = MockTodoRepo();
    });

    testWidgets('TodoPage should display initial UI',
        (WidgetTester tester) async {
      // Stub the getTodos method to return an empty list
      when(mockTodoRepo.getTodos()).thenAnswer((_) async => []);

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: MyApp(todoRepo: mockTodoRepo),
        ),
      );

      // Verify that the initial UI is displayed
      expect(find.byType(TodoPage),
          findsOneWidget); // Verify TodoPage is displayed
      expect(find.byType(FloatingActionButton),
          findsOneWidget); // Verify FAB is displayed
    });

    testWidgets('TodoPage should display a list of todos',
        (WidgetTester tester) async {
      // Stub the getTodos method to return a list of todos
      when(mockTodoRepo.getTodos()).thenAnswer((_) async => [
            Todo(id: 1, text: 'Test Todo 1', isCompleted: false),
            Todo(id: 2, text: 'Test Todo 2', isCompleted: true),
          ]);

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: MyApp(todoRepo: mockTodoRepo),
        ),
      );

      // Wait for the list to load
      await tester.pumpAndSettle();

      // Verify that the list is displayed
      expect(find.text('Test Todo 1'), findsOneWidget);
      expect(find.text('Test Todo 2'), findsOneWidget);
    });

    testWidgets('TodoPage should show an error message when loading fails',
        (WidgetTester tester) async {
      // Stub the getTodos method to throw an exception
      when(mockTodoRepo.getTodos())
          .thenThrow(Exception('Failed to load todos'));

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: MyApp(todoRepo: mockTodoRepo),
        ),
      );

      // Wait for the list to load
      await tester.pumpAndSettle();

      // Verify that an error message is displayed
      expect(find.text('Failed to load todos'), findsOneWidget);
    });
  });
}
