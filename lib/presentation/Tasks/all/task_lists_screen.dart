import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_app/domain/models/task.dart';
import 'package:to_do_app/presentation/Tasks/task_item.dart';

class TaskListsScreen extends StatelessWidget {
  const TaskListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      children: [
        // StaggeredGridTile()
      ],
    );
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Title(color: Colors.black, child: Text('Title')),
                const SizedBox(height: 8),
                ListView.builder(itemBuilder: (context, index) {
                  return TaskItem(
                      task: Task(id: 1, content: "Hello", isDone: true));
                })
              ],
            );
          }),
    );
  }
}
