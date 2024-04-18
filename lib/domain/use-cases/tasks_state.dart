part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksFetched extends TasksState {
  final List<TaskList> tasks;

  TasksFetched({required this.tasks});
}
