import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/models/task_list.dart';
import 'package:to_do_app/domain/use-cases/app/app_cubit.dart';
import 'package:to_do_app/domain/use-cases/tasks/tasks_cubit.dart';
import 'package:to_do_app/presentation/Tasks/all/task_lists_screen.dart';
import 'package:to_do_app/presentation/Tasks/details/task_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  final TasksCubit tasksCubit = serviceLocator();
  runApp(SafeArea(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => tasksCubit),
        BlocProvider(create: (context) => AppCubit())
      ],
      child: const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget with WidgetsBindingObserver {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.green),
      darkTheme: ThemeData(brightness: Brightness.dark, colorSchemeSeed: Colors.green),
      home: Builder(builder: (context) {
        return BlocProvider(
          create: (context) => TasksCubit(serviceLocator()),
          child: Scaffold(
              body: const SafeArea(child: TaskListsScreen()),
              appBar: AppBar(
                title: const Text("All Tasks"),
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final newTaskListId = await context.read<TasksCubit>().addTaskList("");
                  Future.delayed(const Duration(milliseconds: 500));
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TaskListScreen(
                          initialTaskList: TaskList(id: newTaskListId, title: '', tasks: []))));
                  context.read<TasksCubit>().checkAndDeleteEmptyTaskLists();
                },
                child: const Icon(Icons.add),
              )),
        );
      }),
    );
  }
}
