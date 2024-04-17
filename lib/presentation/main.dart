import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/di/injection_container.dart';
import 'package:to_do_app/domain/use-cases/tasks_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(BlocProvider(
    create: (context) => TasksCubit(serviceLocator()),
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Placeholder(),
      ),
    );
  }
}