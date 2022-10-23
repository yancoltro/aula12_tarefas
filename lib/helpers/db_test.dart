import 'package:aula12_tarefas/helpers/db.dart';
import 'package:aula12_tarefas/models/todo.dart';

Future _testData() async {
    DB db = DB();
    await db.database;
    List<Todo> todos = await db.getTodos();
    await db.deleteAll();

    await db.insertTodo(Todo('Levar o carro lavar no Tião',
        'Interna, externa e motor', '25/10/2022', 1));
    await db.insertTodo(Todo('Comprar açucar', '1 Kg', '25/10/2022', 2));
    await db.insertTodo(Todo('Pagar o agiota', '@12.00', '25/10/2022', 3));
    todos = await db.getTodos();

    print('Inserção de teste');
    todos.forEach((Todo todo) {
      print(todo.name);
    });

    // testando update
    Todo todoToUpdate = todos[0];
    todoToUpdate.name = 'Levar o carro lavar no Mané';
    await db.updateTodo(todoToUpdate);

    // testando delete
    Todo todoToDelete = todos[1];
    await db.deleteTodo(todoToDelete);

    print('Depois das atualizações');
    todos = await db.getTodos();
    todos.forEach((Todo todo) {
      print(todo.name);
    });
  }