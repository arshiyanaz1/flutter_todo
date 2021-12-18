import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/counter.dart';
import 'package:todoapp/widgets/new_todo.dart';
import 'package:todoapp/widgets/todo_list.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> todos = [
    Todo(id: Uuid(), title: "Pet the Cat", completed: true),
    Todo(id: Uuid(), title: "cLEAN rOOM", completed: false),
    Todo(id: Uuid(), title: "Dance", completed: false),
  ];

  void _updateTodoCompletions(int index) {
    setState(() {
      todos[index].completed = !todos[index].completed;
    });
  }

  void _showAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bctx) {
          return NewTodo(addTodo: _addToDo);
        });
  }

  void _addToDo(String todo) {
    setState(() {
      todos.add(Todo(id: Uuid(), title: todo, completed: false));
    });
  }

  int _calcTotalCompletions() {
    var totalCompletions = 0;

    todos.forEach((todo) {
      if (todo.completed) {
        totalCompletions++;
      }
    });
    return totalCompletions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Counter(
              numberOfTodos: todos.length,
              totalCompletions: _calcTotalCompletions(),
            ),
            TodoList(todos: todos,updateTodoCompletions: _updateTodoCompletions,)
            /*     ...todos.map((todo) => TodoCard(
                      title: todo.title,
                      completed: todo.completed,
                    ))
                .toList() */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoModal(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
