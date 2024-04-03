import 'dart:html';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(const ProviderScope(child: MainApp()));

class TaskNotifier extends StateNotifier<List<bool>> {
  TaskNotifier(super._state);

  void toggle(int id) {
    state = state.asMap().map((key, value) => MapEntry(key,id == key ? !value : value)).values.toList();
  }
}

final taskStateProvider = StateNotifierProvider<TaskNotifier, List<bool>>(
    (ref) => TaskNotifier([false, false, false, false, false]));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: TaskList(),
        ));
  }
}

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tasks = ref.watch(taskStateProvider);
    var completedTasks = tasks.where((isChecked) => isChecked).toList();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: completedTasks.length / tasks.length,
          ),
          const TaskItem(id: 0, label: "Item 1"),
          const TaskItem(id: 1, label: "Item 2"),
          const TaskItem(id: 2, label: "Item 3"),
          const TaskItem(id: 3, label: "Item 4"),
          const TaskItem(id: 4, label: "Item 5"),
        ],
      ),
    );
  }
}

class TaskItem extends ConsumerWidget {
  final String label;
  final int id;

  const TaskItem({required this.id, required this.label, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(taskStateProvider)[id];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Checkbox(
              value: isChecked,
              onChanged: (newValue) {
                ref.read(taskStateProvider.notifier).toggle(id);
              }),
          Text(label)
        ],
      ),
    );
  }
}
