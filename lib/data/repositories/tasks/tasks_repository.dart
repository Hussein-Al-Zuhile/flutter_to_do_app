import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/database.dart';
import 'package:to_do_app/data/dataSources/local/local_data_source.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task.dart' as domainTask;

@lazySingleton
class TasksRepository {
  LocalDataSource localDataSource;

  TasksRepository({required this.localDataSource});

  Future<void> addTask(TaskEntity taskEntity) async {
    await localDataSource.addTask(taskEntity);
  }

  Future<void> updateTask(domainTask.Task task) async {
    await localDataSource.updateTask(TasksCompanion.insert(
        id: Value(task.id), content: task.content, isDone: Value(task.isDone)));
  }

  Future<void> deleteTask(domainTask.Task task) async {
    await localDataSource.deleteTask(TasksCompanion.insert(
        id: Value(task.id), content: task.content, isDone: Value(task.isDone)));
  }

  Stream<List<Task>> getAllTasks() {
    return localDataSource.getAllTasks();
  }
}
