import 'package:flutter/material.dart';
import 'package:to_do_app/domain/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: task.isDone, onChanged: (bool? value) {}),
        const SizedBox(
          width: 16,
        ),
        Text(task.content),
        const SizedBox(
          width: 16,
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
      ],
    );
  }
}
