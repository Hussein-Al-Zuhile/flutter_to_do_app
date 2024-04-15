import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/dataSources/local/local_data_source.dart';

@lazySingleton
class TasksRepository {
  LocalDataSource localDataSource;

  TasksRepository({required this.localDataSource});

}
