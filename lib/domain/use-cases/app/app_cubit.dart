import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AllTaskLists());

  void changeTitle(AppState newState) {
    emit(newState);
  }
}
