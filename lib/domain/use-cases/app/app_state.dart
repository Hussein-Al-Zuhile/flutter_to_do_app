part of 'app_cubit.dart';

@immutable
sealed class AppState {
  abstract final String title;
}

final class AllTaskLists extends AppState {
  @override
  String get title => "All Tasks";
}

final class TaskListDetails extends AppState {
  @override
  String get title => "Task Details";
}
