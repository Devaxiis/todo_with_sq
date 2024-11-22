import 'dart:convert';
import 'dart:developer';

import 'package:sqlflite/data/local_data_source.dart';
import 'package:sqlflite/domain/models.dart/todo_model.dart';

abstract class TodoRepository {
  Future<int> createTodo(TodoModel todo);
  Future<List<Map<String, dynamic>>> readTodos();
  Future<int> updateTodo(int id, TodoModel data);
  Future<int> updateOne(int id, int iscomplate);
  Future<void> deleteTodo(int id);
}

class TodoRepositoryImpl implements TodoRepository {
  final LocalDataSource dataSource;
  const TodoRepositoryImpl({required this.dataSource});

  @override
  Future<int> createTodo(TodoModel todo) {
    final data = {
      "title": todo.title,
      "description": todo.description,
      "createdAt": todo.createdAt,
      "count":todo.count,
    };
    final response = dataSource.createItem(data);
    log("worked...");
    return response;
  }

  @override
  Future<void> deleteTodo(int id) async {
    return await dataSource.deleteItem(id);
  }

  @override
  Future<List<Map<String, dynamic>>> readTodos() async {
    final response = await dataSource.getItems();
    return response;
  }

  @override
  Future<int> updateTodo(int id, TodoModel todo) async{
    final data = {
      "title": todo.title,
      "description": todo.description,
      "createdAt": todo.createdAt,
      "count":todo.count,
    };

    final res =await dataSource.updateItem(id, data);
    log("$res");
    return res;
  }

  @override
  Future<int> updateOne(int id, int iscomplate) async{
    final data = {
      "count":iscomplate,
    };

    final res =await dataSource.updateItem(id, data);
    log("$res");
    return res;
  }
}
