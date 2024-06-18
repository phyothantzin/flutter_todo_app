import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/new_task_dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box("todo_app");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if (_box.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _inputController = TextEditingController();

  void saveNewTask() {
    setState(() {
      db.todoList.add([_inputController.value.text, false]);

      _inputController.clear();
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return NewTaskDialogBox(
            controller: _inputController,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow[500],
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("TO DO"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.yellow,
        ),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.todoList[index][0].toString(),
              taskCompleted: db.todoList[index][1] as bool,
              onChanged: (value) {
                setState(() {
                  db.todoList[index][1] = value!;
                });
                db.updateDataBase();
              },
              deleteTask: (context) {
                setState(() {
                  db.todoList.removeAt(index);
                  db.updateDataBase();
                });
              },
            );
          },
        ));
  }
}
