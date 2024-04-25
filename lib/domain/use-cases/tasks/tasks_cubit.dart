import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/dataSources/local/database.dart' as dataTask;
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task.dart';
import 'package:to_do_app/domain/models/task_list.dart';

part 'tasks_state.dart';

@singleton
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _tasksRepository;

  TasksCubit(this._tasksRepository) : super(TasksInitial()) {
    emit(TasksLoading());
    _tasksRepository.getAllTaskLists().listen((tasks) {
      emit(TasksFetched(taskLists: tasks));
    });
  }

  void addTask(TaskEntity taskEntity) async {
    await _tasksRepository.addTask(taskEntity);
  }

  void updateTask(Task task) async {
    await _tasksRepository.updateTask(task);
  }

  void deleteTask(Task task) async {
    await _tasksRepository.deleteTask(task);
  }

  Future<int> addTaskList(String title) async {
    return await _tasksRepository.addTaskList(title);
  }

  void updateTaskList(int id, String title) async {
    await _tasksRepository.updateTaskList(id, title);
  }

  void deleteTaskList(int id) async {
    await _tasksRepository.deleteTaskList(id);
  }

  Future<void> checkAndDeleteEmptyTaskLists() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _tasksRepository.getAllTaskLists().first.then((taskLists) {
      for (final taskList in taskLists) {
        if (taskList.title.isEmpty && taskList.tasks.isEmpty) {
          deleteTaskList(taskList.id);
        }
      }
    });
  }
}

extension on dataTask.Task {
  Task toDomainTask() => Task(id: id, content: content, isDone: isDone, taskListId: taskListId);
}
