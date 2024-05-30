import 'package:flutter/cupertino.dart';

@immutable
class Task {
  final int id;
  final String content;
  final bool isDone;
  final int taskListId;

  const Task(
      {required this.id, required this.content, required this.isDone, required this.taskListId});
}
