import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/model/task_model.dart';
import 'package:task_manager_app/view/home_screen.dart';
import 'package:task_manager_app/view_model/screen_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager_app/view_model/todo_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  await Firebase.initializeApp();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('containerBox');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ScreenModel()),
      ChangeNotifierProvider(create: (_) => TodoModel()),
    ],
    child: const MyApp(),
  ));
}
