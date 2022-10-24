import 'package:aula12_tarefas/bloc/todo_bloc.dart';
import 'package:aula12_tarefas/bloc/todo_events.dart';
import 'package:aula12_tarefas/bloc/todo_state.dart';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:aula12_tarefas/screens/todo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoBloc bloc = TodoBloc();

  @override
  void initState() {
    bloc.sink.add(ListTodoEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _testDb();
    Todo todo = Todo("", "", "", 0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
      ),
      body: Container(
        child: StreamBuilder<TodoState>(
          stream: bloc.stream,
          // initialData: ,
          builder: (BuildContext context, AsyncSnapshot<TodoState> snapshot) {
            List<Todo> todos =
                snapshot.data != null ? snapshot.data!.todos : [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(todos[index].id.toString()),
                  onDismissed: (obj) =>
                      bloc.sink.add(DeleteTodoEvent(todos[index])),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).highlightColor,
                      child: Text("${todos[index].priority}"),
                    ),
                    title: Text("${todos[index].name}"),
                    subtitle: Text("${todos[index].description}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TodoPage(todos[index], false)),
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
