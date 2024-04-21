import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/database.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:tuple/tuple.dart';

@lazySingleton
class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource({required AppDatabase database}) : _database = database;

  Future<void> addTask(TaskEntity taskEntity) async {
    await _database.tasks.insertOne(TasksCompanion.insert(
        content: taskEntity.content,
        isDone: Value(taskEntity.isDone),
        taskListId: taskEntity.taskListId));
  }

  Future<void> updateTask(TasksCompanion task) async {
    await (_database.tasks.update()
      ..whereSamePrimaryKey(task)).write(task);
  }

  Future<void> deleteTask(TasksCompanion task) async {
    await _database.tasks.deleteOne(task);
  }

  Stream<List<Task>> getAllTasks() {
    return _database.tasks.select().watch();
  }

  Future<int> addTaskList(String title) async {
    return await _database.taskLists.insertOne(TaskListsCompanion.insert(title: title));
  }

  Stream<List<Tuple2<TaskList, List<Task>>>> getAllTaskLists() {
    return _database.taskLists.select().watch().asyncExpand((taskLists) async* {
      yield await Future.wait(taskLists.map((taskList) async {
        final tasksOfTaskList = await (_database.tasks.select()
          ..where((task) => task.taskListId.equals(taskList.id)))
            .get();
        return Tuple2(taskList, tasksOfTaskList);
      }));
    });
  }
}
