import 'dart:async';

import 'package:aula12_tarefas/helpers/db.dart';
import 'package:aula12_tarefas/models/todo.dart';

class TodoBloc {
  late DB db;
  late List<Todo> todoList = [];

  TodoBloc() {
    db = DB();
    getTodos();

    // registrando os listeners para escutarem os eventos
    _todosStreamController.stream.listen(returnTodos);
    _todoInsertController.stream.listen(_addTodo);
    _todoUpdateController.stream.listen(_updateTodo);
    _todoDeleteController.stream.listen(_deleteTodo);
  }

  // criando os controladores de cada fluxo stream
  final _todosStreamController = StreamController<List<Todo>>.broadcast();
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  Stream<List<Todo>> get todos => _todosStreamController.stream;
  StreamSink<List<Todo>> get todosSink => _todosStreamController.sink;
  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;
  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;
  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  // metodos de logica
  Future getTodos() async {
    List<Todo> todos = await db.getTodos();
    todoList = todos;
    todosSink.add(todos);
  }

  List<Todo> returnTodos(todos) {
    return todos;
  }

  void _addTodo(Todo todo) async {
    db.insertTodo(todo).then((result) => getTodos());
  }

  void _updateTodo(Todo todo) async {
    db.updateTodo(todo).then((result) => getTodos());
  }

  void _deleteTodo(Todo todo) async {
    db.deleteTodo(todo).then((result) => getTodos());
  }

  // libera os recursos usados no aplicativo
  void dispose() {
    _todosStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
