import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  final _box = Hive.box("todo_app");

  final List todoList = [];

  void createInitialData() {
    todoList.addAll([
      ["Buy milk", false],
      ["Buy egg", false],
      ["Buy bread", false],
    ]);
  }

  void loadData() {
    todoList.addAll(_box.get("TODOLIST"));
  }

  void updateDataBase() {
    _box.put("TODOLIST", todoList);
  }
}
