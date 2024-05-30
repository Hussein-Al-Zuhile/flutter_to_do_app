import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task_list.dart';
import 'package:to_do_app/domain/use-cases/tasks/tasks_cubit.dart';
import 'package:to_do_app/presentation/Tasks/details/task_item.dart';

class TaskListScreen extends StatelessWidget {
  final TasksRepository tasksRepository = serviceLocator();
  final TaskList initialTaskList;

  final _taskTextController = TextEditingController();
  final _titleTextController = TextEditingController();

  TaskListScreen({super.key, required this.initialTaskList}) {
    _titleTextController.text = initialTaskList.title;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(serviceLocator()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task Details"),
          centerTitle: true,
        ),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if ((state is TasksFetched)) {
              final taskList =
                  state.taskLists.firstWhere((element) => element.id == initialTaskList.id);
              Timer? timer;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (text) async {
                        timer?.cancel();
                        timer = Timer(const Duration(milliseconds: 500), () {
                          context.read<TasksCubit>().updateTaskList(initialTaskList.id, text);
                        });
                      },
                      controller: _titleTextController,
                      decoration: InputDecoration(
                          hintText: 'Title..',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _titleTextController.clear();
                                context.read<TasksCubit>().updateTaskList(initialTaskList.id, "");
                              },
                              icon: const Icon(Icons.clear))),
                      autofocus: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: (text) {
                        context.read<TasksCubit>().addTask(TaskEntity(
                            content: text, isDone: false, taskListId: initialTaskList.id));
                        _taskTextController.clear();
                      },
                      controller: _taskTextController,
                      decoration: const InputDecoration(filled: true, hintText: 'Add new task..'),
                    ),
                  ),
                  Flexible(
                    child: ListView.separated(
                      itemCount: taskList.tasks.length,
                      itemBuilder: (buildContext, int index) {
                        return TaskItem(
                          task: taskList.tasks[index],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
