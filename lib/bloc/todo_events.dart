import 'package:aula12_tarefas/models/todo.dart';

abstract class TodoEvent {}

class ListTodoEvent extends TodoEvent {}

class InsertTodoEvent extends TodoEvent {
  Todo todo;

  InsertTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  Todo todo;

  UpdateTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodoEvent {
  Todo todo;

  DeleteTodoEvent(this.todo);
}
