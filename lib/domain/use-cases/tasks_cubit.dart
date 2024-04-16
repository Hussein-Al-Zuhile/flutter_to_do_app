import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/data/dataSources/local/database.dart' as dataTask;
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart';
import 'package:to_do_app/domain/entities/task_entity.dart';
import 'package:to_do_app/domain/models/task.dart';

part 'tasks_state.dart';

@injectable
class TasksCubit extends Cubit<TasksState> {
  final TasksRepository tasksRepository;

  TasksCubit(this.tasksRepository) : super(TasksInitial()) {
    tasksRepository.getAllTasks().listen((tasks) {
      emit(TasksFetched(tasks: tasks.map((task) => task.toDomainTask()).toList()));
    });
  }

  void addTask(TaskEntity taskEntity) async {
    await tasksRepository.addTask(taskEntity);
  }

  void updateTask(Task task) async {
    await tasksRepository.updateTask(task);
  }

}

extension on dataTask.Task {
  Task toDomainTask() => Task(id: id, content: content, isDone: isDone);
}
