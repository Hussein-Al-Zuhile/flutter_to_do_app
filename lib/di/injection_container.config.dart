// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:to_do_app/data/dataSources/local/database.dart' as _i3;
import 'package:to_do_app/data/dataSources/local/local_data_source.dart' as _i4;
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart' as _i5;
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppDatabase>(() => _i3.AppDatabase());
    gh.lazySingleton<_i4.LocalDataSource>(
        () => _i4.LocalDataSource(database: gh<_i3.AppDatabase>()));
    gh.lazySingleton<_i5.TasksRepository>(
        () => _i5.TasksRepository(localDataSource: gh<_i4.LocalDataSource>()));
    gh.factory<_i6.TasksCubit>(() => _i6.TasksCubit(gh<_i5.TasksRepository>()));
    return this;
  }
}
