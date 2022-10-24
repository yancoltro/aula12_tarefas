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

  

}