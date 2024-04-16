import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart';
import 'package:to_do_app/presentation/Tasks/task_item.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(BlocProvider(
    create: (context) => TasksCubit(serviceLocator()),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final TasksRepository tasksRepository = serviceLocator();

  Home({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if ((state is TasksFetched)) {
          return Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (text) {
                    context.read<TasksCubit>().addTask(TaskEntity(content: text, isDone: false));
                    textController.clear();
                  },
                  controller: textController,
                  decoration: InputDecoration(filled: true),
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (buildContext, int index) {
                      return TaskItem(
                        task: state.tasks[index],
                      );
                    }),
              ),
            ],
          );
        } else {
          return Placeholder();
        }
      },
    );
  }
}