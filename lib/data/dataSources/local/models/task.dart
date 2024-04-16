import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get content => text()();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  // IntColumn get taskList => integer().references(TaskLists, #id, onDelete: KeyAction.cascade)();
}