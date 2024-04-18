import 'package:drift/drift.dart';
import 'package:to_do_app/data/dataSources/local/models/task_list.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text()();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  IntColumn get taskListId => integer().references(TaskLists, #id, onDelete: KeyAction.cascade)();
}