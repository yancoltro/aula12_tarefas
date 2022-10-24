import 'package:aula12_tarefas/helpers/db.dart';
import 'package:aula12_tarefas/interfaces/dao.dart';
import 'package:aula12_tarefas/models/todo.dart';
import 'package:sembast/sembast.dart';

class TodoDao extends DAO<Todo> {
  late DB db;
  final _store = intMapStoreFactory.store('todos');
  TodoDao() {
    db = DB();
  }

  Future insert(Todo todo) async {
    await _store.add((await db.database)!, todo.toMap());
  }

  Future update(Todo todo) async {
    final finder =
        Finder(filter: Filter.byKey(todo.id)); // realizara a busca no banco
    await _store.update((await db.database)!, todo.toMap(), finder: finder);
  }

  Future delete(Todo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await _store.delete((await db.database)!, finder: finder);
  }

  Future<List<Todo>> list() async {
    final finder = Finder(sortOrders: [
      SortOrder('priority'),
      SortOrder('id'),
    ]);
    final todosSnapshot =
        await _store.find((await db.database)!, finder: finder);
    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  Future deleteAll() async {
    await _store.delete((await db.database)!);
  }

  /*
  Future _testData() async {
    await deleteAll();
    await insert(Todo('Levar o carro lavar no Tião', 'Interna, externa e motor',
        '25/10/2022', 1));
    await insert(Todo('Comprar açucar', '1 Kg', '25/10/2022', 2));
    await insert(Todo('Pagar o agiota', '@12.00', '25/10/2022', 3));

    List<Todo> todos = await list();

    print('Inserção de teste');
    todos.forEach((Todo todo) {
      print(todo.name);
    });

    // testando update
    Todo todoToUpdate = todos[0];
    todoToUpdate.name = 'Levar o carro lavar no Mané';
    await update(todoToUpdate);

    // testando delete
    Todo todoToDelete = todos[1];
    await delete(todoToDelete);

    print('Depois das atualizações');
    todos = await list();
    todos.forEach((Todo todo) {
      print(todo.name);
    });
  }
  */
}
