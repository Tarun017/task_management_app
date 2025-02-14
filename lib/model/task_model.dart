import 'package:hive/hive.dart';

part 'task_model.g.dart';


@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(1)
  late String title;
  @HiveField(2)
  late bool isComplete;
  @HiveField(3)
  late String taskDesc;
  @HiveField(4)
  late int id;
  Task({required this.title, this.isComplete=false,required this.taskDesc,required this.id});
}
