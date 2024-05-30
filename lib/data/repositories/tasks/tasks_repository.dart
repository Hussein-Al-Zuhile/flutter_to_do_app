import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/database.dart';
import 'package:to_do_app/data/dataSources/local/local_data_source.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task.dart' as domainTask;
import 'package:to_do_app/domain/models/task_list.dart' as domainTaskList;

@lazySingleton
class TasksRepository {
  final LocalDataSource _localDataSource;

  TasksRepository({required LocalDataSource localDataSource}) : _localDataSource = localDataSource;

  Future<void> addTask(TaskEntity taskEntity) async {
    await _localDataSource.addTask(taskEntity);
  }

  Future<void> updateTask(domainTask.Task task) async {
    await _localDataSource.updateTask(TasksCompanion.insert(
        id: Value(task.id),
        content: task.content,
        isDone: Value(task.isDone),
        taskListId: task.taskListId));
  }

  Future<void> deleteTask(domainTask.Task task) async {
    await _localDataSource.deleteTask(TasksCompanion.insert(
        id: Value(task.id),
        content: task.content,
        isDone: Value(task.isDone),
        taskListId: task.taskListId));
  }

  Stream<List<Task>> getAllTasks() {
    return _localDataSource.getAllTasks();
  }

  Future<int> addTaskList(String title) async => await _localDataSource.addTaskList(title);

  Future<void> updateTaskList(int id, String title) async =>
      await _localDataSource.updateTaskList(id, title);

  Future<void> deleteTaskList(int id) async => await _localDataSource.deleteTaskList(id);

  Stream<List<domainTaskList.TaskList>> getAllTaskLists() {
    return _localDataSource.getAllTaskLists().map((taskLists) => taskLists
        .map((tuple) => domainTaskList.TaskList(
            id: tuple.item1.id,
            title: tuple.item1.title,
            tasks: tuple.item2
                .map((e) => domainTask.Task(
                    id: e.id, content: e.content, isDone: e.isDone, taskListId: e.taskListId))
                .toList()))
        .toList());
  }
}
