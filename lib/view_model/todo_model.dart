import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/task_model.dart';

class TodoModel with ChangeNotifier {
  final Box<Task> _todoBox = Hive.box<Task>('containerBox');
  List<Task> get todoBox => _todoBox.values.toList();

  // add todo:
  void addTodo(String title,String taskDesc,int id) {
    final newTodo = Task(title: title,taskDesc: taskDesc,id: id);
    _todoBox.add(newTodo);

    notifyListeners();
  }

  // Delete Task:
   void deleteTask(Task todo) {
    todo.delete();
    notifyListeners();
  }
// Update Task:
  void updateTask(Task todo) {
    _todoBox.putAt(todoBox.indexWhere((element) => element.id==todo.id), todo);
   notifyListeners();
  }
}
