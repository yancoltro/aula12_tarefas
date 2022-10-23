import 'dart:async';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  static final DB _singleton = DB._internal();
  Database? _database;

  DB._internal();
  factory DB() => _singleton;

  DatabaseFactory dbFactory =
      databaseFactoryIo; // permite abrir conexao com o banco
  final store =
      intMapStoreFactory.store('todos'); // cria referencencia para o banco

  // metodo get no padrao singleton, retorno somente uma instancia
  Future<Database?> get database async {
    if (_database == null) {
      await _openDb().then((db) {
        _database = db;
      });
    }
    return _database;
  }

  Future _openDb() async {
    final docsPath =
        await getApplicationDocumentsDirectory(); // path_provider, recupera diretorio de bancos
    final dbPath = join(docsPath.path, 'todos.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future insertTodo(Todo todo) async {
    await store.add(_database!, todo.toMap());
  }

  Future updateTodo(Todo todo) async {
    final finder =
        Finder(filter: Filter.byKey(todo.id)); // realizara a busca no banco
    await store.update(_database!, todo.toMap(), finder: finder);
  }

  Future deleteTodo(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(_database!, finder: finder);
  }

  Future<List<Todo>> getTodos() async {
    await database;
    final finder = Finder(sortOrders: [
      SortOrder('priority'),
      SortOrder('id'),
    ]);
    final todosSnapshot = await store.find(_database!, finder: finder);
    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  Future deleteAll() async {
    await store.delete(_database!);
  }
}
