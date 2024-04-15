import 'package:drift/drift.dart';

class TaskLists extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();
}
