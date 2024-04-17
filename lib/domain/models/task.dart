import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_app/data/dataSources/local/models/task_list.dart';

@immutable
class Task {
  final int id;
  final String content;
  final bool isDone;

  const Task({required this.id, required this.content, required this.isDone});
}
