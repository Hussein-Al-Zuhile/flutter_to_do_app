
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/database.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';

@lazySingleton
class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource({required AppDatabase database}) : _database = database;

  Future<void> addTask(TaskEntity taskEntity) async {
    await _database.tasks.insertOne(
        TasksCompanion.insert(content: taskEntity.content, isDone: Value(taskEntity.isDone)));
  }

  Future<void> updateTask(TasksCompanion task) async {
    await _database.tasks.update().write(task);
  }

  Future<void> deleteTask(TasksCompanion task) async {
    await _database.tasks.deleteOne(task);
  }

  Stream<List<Task>> getAllTasks() {
    return _database.tasks.select().watch();
  }
}
