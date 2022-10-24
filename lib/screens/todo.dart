import 'package:aula12_tarefas/bloc/todo_bloc.dart';
import 'package:aula12_tarefas/bloc/todo_events.dart';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:aula12_tarefas/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class TodoPage extends StatelessWidget {
  final Todo todo;
  final bool isNew;

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();

  final TodoBloc bloc;
  TodoPage(this.todo, this.isNew) : bloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    txtName.text = todo.name;
    txtDescription.text = todo.description;
    txtCompleteBy.text = todo.completeBy;
    txtPriority.text = todo.priority.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Tarefa'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: txtName,
              decoration: InputDecoration(hintText: "Nome"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: txtDescription,
              decoration: InputDecoration(hintText: "Descrição"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: txtCompleteBy,
              decoration: InputDecoration(hintText: "Completar até"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Prioridade"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                save().then((_) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    ));
              },
            ),
          )
        ],
      )),
    );
  }

  Future save() async {
    todo.name = txtName.text;
    todo.description = txtDescription.text;
    todo.completeBy = txtCompleteBy.text;
    todo.priority = int.tryParse(txtPriority.text)!;
    if (isNew) {
      bloc.sink.add(InsertTodoEvent(todo));
    } else {
      bloc.sink.add(UpdateTodoEvent(todo));
    }
  }
}
