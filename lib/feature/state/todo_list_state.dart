part of 'todo_list_bloc.dart';

abstract class TodoListState {
  List<Todo> todos;
  TodoListState({required this.todos});
}

class TodoListInitialState extends TodoListState {
  TodoListInitialState({required super.todos});
}

class TodoListLoadingState extends TodoListState {
  TodoListLoadingState({required super.todos});
}

class TodoListLoadedState extends TodoListState {
  TodoListLoadedState({required super.todos});
}

class TodoListEmptyState extends TodoListState {
  TodoListEmptyState({required super.todos});
}

class TodoListErrorState extends TodoListState {
  final String error;
  TodoListErrorState({required super.todos, required this.error});
}

class TodoListSuccessState extends TodoListState {
  TodoListSuccessState({required super.todos});
}
