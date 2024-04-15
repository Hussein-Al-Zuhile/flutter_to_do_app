import 'package:to_do_app/domain/models/task.dart';

class TaskList {
  final int id;
  final String title;
  final List<Task> tasks;

  TaskList({required this.id, required this.title, required this.tasks});
}
