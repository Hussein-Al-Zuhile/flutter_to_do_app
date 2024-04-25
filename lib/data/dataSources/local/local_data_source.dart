import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
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
    await (_database.tasks.update()..whereSamePrimaryKey(task)).write(task);
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

  Future<void> updateTaskList(int id, String title) async {
    await (_database.taskLists.update()..where((tbl) => tbl.id.equals(id)))
        .write(TaskListsCompanion.insert(id: Value(id), title: title));
  }

  Future<void> deleteTaskList(int id) async {
    await (_database.taskLists.deleteWhere((tbl) => tbl.id.equals(id)));
  }

  Stream<List<Tuple2<TaskList, List<Task>>>> getAllTaskLists() {
    return Rx.combineLatest2(_database.taskLists.select().watch(), _database.tasks.select().watch(),
        (taskLists, tasks) {
      return taskLists.map((taskList) {
        final tasksOfTaskList = tasks.where((task) => task.taskListId == taskList.id).toList();
        return Tuple2(taskList, tasksOfTaskList);
      }).toList();
    });
  }
}
