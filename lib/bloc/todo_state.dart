import 'package:aula12_tarefas/models/todo.dart';

abstract class TodoState {
  List<Todo> todos;

  TodoState(this.todos);
}

class TodoInitialState extends TodoState {
  TodoInitialState() : super([]);
}

class TodoSuccessState extends TodoState {
  TodoSuccessState(List<Todo> todos) : super(todos);
}
