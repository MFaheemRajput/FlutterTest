import 'package:bloc/bloc.dart';
import '../../models/todo.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitialState(todos: [])) {
    on<AddTodoEvent>((event, emit) {
      emit(TodoListInitialState(todos: []));
      emit(TodoListLoadingState(todos: []));
      final List<Todo> updateTodos = List.from(event.todos)..add(event.todo);
      emit(TodoListLoadedState(todos: updateTodos));
    });

    on<RemoveTodoEvent>((event, emit) {
      emit(TodoListInitialState(todos: []));
      emit(TodoListLoadingState(todos: []));
      final List<Todo> updateTodos = List.from(event.todos)..remove(event.todo);
      emit(TodoListLoadedState(todos: updateTodos));
    });
    on<FilterTodoEvent>((event, emit) {
      emit(TodoListInitialState(todos: []));
      emit(TodoListLoadingState(todos: []));
      final List<Todo> workingList = List.from(event.todos);
      workingList.forEach((todo) {
        if (checkGoalString(todo.name)) {
          todo.colorCode = "#008000";
        } else {
          todo.colorCode = "#ff0000";
        }
      });
      print(workingList);
      emit(TodoListLoadedState(todos: workingList));
    });
  }

  bool checkGoalString(String input) {
    // Regular expression to match only allowed characters (G, O, A, L, and 3)
    RegExp regExp = RegExp(r'[GgOoAaLl3]');

    // Return true if the string matches the pattern, otherwise false
    return regExp.hasMatch(input);
  }
}
