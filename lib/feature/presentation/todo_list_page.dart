import 'package:flutter/material.dart';
import 'package:flutter_application_bloc/feature/state/todo_list_bloc.dart';
import 'package:flutter_application_bloc/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the counter or any other state here if needed
  }

  @override
  void dispose() {
    // Dispose of any resources if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Filter'),
        onPressed: () {
          // Example of adding a todo
          print("FAHEEM");
          print(_todos);
          context.read<TodoListBloc>().add(FilterTodoEvent(todos: _todos));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: const Text('Todos List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                // Example of adding a todo
                context.read<TodoListBloc>().add(
                  AddTodoEvent(todo: Todo(name: value), todos: _todos),
                );
                _controller.clear();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter text',
              ),
            ),

            Expanded(
              child: BlocBuilder<TodoListBloc, TodoListState>(
                builder: (context, state) {
                  if (state is TodoListInitialState) {
                    return const Center(child: Text('Initial state'));
                  }
                  if (state is TodoListEmptyState) {
                    return const Center(child: Text('No Todos found'));
                  }
                  if (state is TodoListLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is TodoListErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  if (state is TodoListLoadedState) {
                    _todos.clear();
                    _todos.addAll(state.todos);
                    return ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _todos[index].name,
                            style: TextStyle(
                              color: _getColorFromHex(_todos[index].colorCode),
                            ),
                          ),
                          subtitle: Text(_todos[index].id),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Example of removing a todo
                              context.read<TodoListBloc>().add(
                                RemoveTodoEvent(todo: _todos[index], todos: []),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('Unknown state'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexColor) {
    // Remove the '#' if it exists and parse the remaining string as hex
    String colorCode = hexColor.replaceAll('#', '');

    // Parse the color code and add '0xFF' for full opacity (255 alpha)
    return Color(int.parse('0xFF$colorCode'));
  }
}
