import 'package:aula12_tarefas/bloc/todo_bloc.dart';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:aula12_tarefas/screens/todo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TodoBloc todoBloc;
  late List<Todo> todos = [];

  @override
  void initState() {
    todoBloc = TodoBloc();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _testDb();
    Todo todo = Todo("", "", "", 0);
    todos = todoBloc.todoList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
      ),
      body: Container(
        child: StreamBuilder<List<Todo>>(
          stream: todoBloc.todos,
          initialData: todos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: (snapshot.hasData) ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  onDismissed: (obj) =>
                      todoBloc.todoDeleteSink.add(snapshot.data[index]),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).highlightColor,
                      child: Text("${snapshot.data[index].priority}"),
                    ),
                    title: Text("${snapshot.data[index].name}"),
                    subtitle: Text("${snapshot.data[index].description}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TodoPage(snapshot.data[index], false)),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoPage(todo, true)),
          );
        },
      ),
    );
  }
}
