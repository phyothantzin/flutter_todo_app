import "package:flutter/material.dart";

class NewTaskDialogBox extends StatelessWidget {
  dynamic controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  NewTaskDialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onSave,
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: onCancel,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
