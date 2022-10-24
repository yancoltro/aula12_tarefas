import 'dart:async';

abstract class DAO<T>{
  Future insert(T t);
  Future update(T t);
  Future delete(T t);
  Future<List<T>> list();
}