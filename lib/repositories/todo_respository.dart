import 'package:aula12_tarefas/daos/todo_dao.dart';
import 'package:aula12_tarefas/models/todo.dart';

class TodoRepository {
  TodoDao dao = TodoDao();

  Future<List<Todo>> repoList() async {
    return await dao.list();
  }

  Future<List<Todo>> repoInsert(Todo todo) async {
    await dao.insert(todo);
    return dao.list();
  }

  Future<List<Todo>> repoUpdate(Todo todo) async {
    await dao.update(todo);
    return dao.list();
  }

  Future<List<Todo>> repoDelete(Todo todo) async {
    await dao.delete(todo);
    return dao.list();
  }
}
