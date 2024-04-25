// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:to_do_app/data/dataSources/local/database.dart' as _i4;
import 'package:to_do_app/data/dataSources/local/local_data_source.dart' as _i5;
import 'package:to_do_app/data/repositories/tasks/tasks_repository.dart' as _i6;
import 'package:to_do_app/domain/use-cases/app/app_cubit.dart' as _i3;
import 'package:to_do_app/domain/use-cases/tasks/tasks_cubit.dart' as _i7;

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
    gh.factory<_i3.AppCubit>(() => _i3.AppCubit());
    gh.lazySingleton<_i4.AppDatabase>(() => _i4.AppDatabase());
    gh.lazySingleton<_i5.LocalDataSource>(
        () => _i5.LocalDataSource(database: gh<_i4.AppDatabase>()));
    gh.lazySingleton<_i6.TasksRepository>(
        () => _i6.TasksRepository(localDataSource: gh<_i5.LocalDataSource>()));
    gh.singleton<_i7.TasksCubit>(
        () => _i7.TasksCubit(gh<_i6.TasksRepository>()));
    return this;
  }
}
