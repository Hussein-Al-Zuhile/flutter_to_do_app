import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/dataSources/local/database.dart' as dataTask;
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task.dart';
import 'package:to_do_app/domain/models/task_list.dart';

part 'tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository _tasksRepository;

  TasksCubit(this._tasksRepository) : super(TasksInitial()) {
    emit(TasksLoading());
    _tasksRepository.getAllTaskLists().listen((tasks) {
      emit(TasksFetched(tasks: tasks));
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
}

extension on dataTask.Task {
  Task toDomainTask() => Task(id: id, content: content, isDone: isDone, taskListId: taskListId);
}
