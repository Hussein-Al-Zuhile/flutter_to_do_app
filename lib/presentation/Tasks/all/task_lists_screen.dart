import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/models/task.dart';
import 'package:to_do_app/domain/models/task_list.dart';
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart';
import 'package:to_do_app/presentation/Tasks/task_item.dart';

class TaskListsScreen extends StatelessWidget {
  const TaskListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(serviceLocator()),
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksFetched) {
            return SingleChildScrollView(
                child: StaggeredGrid.count(
                    crossAxisCount: state.tasks.length,
                    children:
                        state.tasks.map((taskList) => TaskListItem(taskList: taskList)).toList()));
          } else {
            return const Placeholder();
          }
        },
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.taskList});

  final TaskList taskList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Title(color: Colors.black, child: Text(taskList.title)),
            const SizedBox(height: 8),
            Column(
              children: taskList.tasks.map((task) => TaskItem(task: task)).toList(),
            )
          ],
        ),
      ),
    );
  }
}
