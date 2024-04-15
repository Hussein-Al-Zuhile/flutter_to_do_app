import 'package:drift/drift.dart';
import 'package:to_do_app/data/dataSources/local/models/task_list.dart';

class Task {
  final int id;
  final String content;
  final bool isDone;
  final int taskListId;

  Task({required this.id, required this.content, required this.isDone, required this.taskListId});
}