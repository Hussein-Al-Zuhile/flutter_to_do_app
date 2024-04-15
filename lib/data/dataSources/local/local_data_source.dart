import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/database.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task_list.dart' as domain;

@lazySingleton
class LocalDataSource {
  final AppDatabase _database;

  LocalDataSource({required AppDatabase database}) : _database = database;

  Future<void> addTaskList(String taskListTitle, List<TaskEntity> taskEntities) {
    return _database.transaction(() async {
      final taskListId = await _database
          .into(_database.taskLists)
          .insert(TaskListsCompanion.insert(title: taskListTitle));
      final tasks = taskEntities
          .map((e) =>
          TasksCompanion.insert(
              content: e.content, isDone: Value(e.isDone), taskListId: taskListId))
          .toList();
      await _database.batch((batch) {
        batch.insertAll(_database.tasks, tasks);
      });
    });
  }

  Stream<List<domain.TaskList>> getAllTaskLists() =>
      // _database.select(_database.tasks).join([
      //   leftOuterJoin(
      //       _database.taskLists, _database.taskLists.id.equalsExp(_database.tasks.taskList))
      // ]).watch().map((rows) {
      //   return rows.map((row) {
      //     final taskList = row.readTable(_database.taskLists);
      //     final task = row.readTable(_database.tasks);
      //     return domain.TaskList(id: taskList.id, title: taskList.title,tas);
      //   })
      // })
}
