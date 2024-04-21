import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/models/task_list.dart';
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart';
import 'package:to_do_app/presentation/Tasks/all/task_lists_screen.dart';
import 'package:to_do_app/presentation/Tasks/task_list_screen.dart';

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
      home: Builder(
          builder: (context) {
            return BlocProvider(
              create: (context) => TasksCubit(serviceLocator()),
              child: Scaffold(
                body: const TaskListsScreen(),
                floatingActionButton: Builder(
                  builder: (context) {
                    return FloatingActionButton(
                      onPressed: () async {
                        final newTaskListId = await context.read<TasksCubit>().addTaskList("title1");
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => TaskListScreen(taskList: TaskList(id: newTaskListId, title: "title1", tasks: []))));
                      },
                      child: const Icon(Icons.add),
                    );
                  }
                ),
              ),
            );
          }
      ),
    );
  }
}
