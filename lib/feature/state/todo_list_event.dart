part of 'todo_list_bloc.dart';

abstract class TodoListEvent {
  List<Todo> todos;
  TodoListEvent({required this.todos});
}

class AddTodoEvent extends TodoListEvent {
  final Todo todo;
  AddTodoEvent({required this.todo, required super.todos});
}

class RemoveTodoEvent extends TodoListEvent {
  final Todo todo;
  RemoveTodoEvent({required this.todo, required super.todos});
}

class FilterTodoEvent extends TodoListEvent {
  FilterTodoEvent({required super.todos});
}
