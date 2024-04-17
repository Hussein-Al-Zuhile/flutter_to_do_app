import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/domain/models/task.dart';
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: task.isDone, onChanged: (bool? value) {
          context.read<TasksCubit>().updateTask(
              Task(id: task.id, content: task.content, isDone: !task.isDone));
        }),
        const SizedBox(
          width: 16,
        ),
        Text(task.content),
        const SizedBox(
          width: 16,
        ),
        IconButton(onPressed: () {
          context.read<TasksCubit>().deleteTask(task);
        }, icon: const Icon(Icons.delete))
      ],
    );
  }
}
