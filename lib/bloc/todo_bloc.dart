import 'dart:async';

import 'package:aula12_tarefas/bloc/todo_events.dart';
import 'package:aula12_tarefas/bloc/todo_state.dart';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:aula12_tarefas/repositories/todo_respository.dart';

class TodoBloc {
  final _repo = TodoRepository();

  final StreamController<TodoEvent> _input = StreamController<TodoEvent>();
  final StreamController<TodoState> _output = StreamController<TodoState>();

  Sink<TodoEvent> get sink => _input.sink;
  Stream<TodoState> get stream => _output.stream;

  TodoBloc() {
    _input.stream.listen(_mapBloc);
  }

  _mapBloc(TodoEvent event) async {
    List<Todo> todos = [];
    if (event is ListTodoEvent) {
      todos = await _repo.repoList();
    } else if (event is InsertTodoEvent) {
      todos = await _repo.repoInsert(event.todo);
    } else if (event is UpdateTodoEvent) {
      todos = await _repo.repoUpdate(event.todo);
    } else if (event is DeleteTodoEvent) {
      todos = await _repo.repoDelete(event.todo);
    }

    _output.add(TodoSuccessState(todos));
  }
}
