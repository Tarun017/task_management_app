import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/view/add_task_dialog.dart';
import 'package:task_manager_app/view/delete_task_dialog.dart';
import 'package:task_manager_app/view/update_task_dialog.dart';
import 'package:task_manager_app/view_model/screen_model.dart';
import 'package:task_manager_app/view_model/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final screenModel = Provider.of<ScreenModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenModel = Provider.of<ScreenModel>(context);
    final todoModel = Provider.of<TodoModel>(context);
    final todos = todoModel.todoBox;

    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text(
          'Task Management',
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),

        ),
        actions: [
          Row(
            children: [
              const Text(
                'Sync Firestore',
                style: TextStyle(fontSize: 12),

              ),
              CupertinoSwitch(
                value: !screenModel.offlineMode,
                onChanged: (value) async {
                  screenModel.toggleMode();
                  Future.delayed(const Duration(seconds: 2), () {
                    screenModel.toggleMode();
                  });
                  if (!screenModel.offlineMode) {
                    final todoModel =
                    Provider.of<TodoModel>(context, listen: false);
                    final todos = todoModel.todoBox;
                    CollectionReference tasks =
                    FirebaseFirestore.instance.collection('tasks');

                    tasks.get().then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        doc.reference.delete();
                      });
                      for (int index = 0; index < todos.length; index++) {
                        tasks.add(
                          {
                            'id': todos[index].id,
                            'title': todos[index].title,
                            'taskDesc': todos[index].taskDesc,
                          },
                        );
                      }

                    });
                  }

                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Visibility(
              visible:!screenModel.offlineMode ,
                child: LinearProgressIndicator()),
             ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                final taskDetails = todos[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 5), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                    title: Text(taskDetails.title),
                    subtitle: Text(taskDetails.taskDesc),

                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text(
                              'Edit',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: () {
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(
                                  context: context,
                                  builder: (context) => UpdateTaskAlertDialog(
                                    todu: taskDetails,
                                  ),
                                ),
                              );
                            },
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text(
                              'Delete',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            onTap: () {
                              int taskId = taskDetails.id;
                              String taskName = taskDetails.title;
                              Future.delayed(
                                const Duration(seconds: 0),
                                    () => showDialog(
                                  context: context,
                                  builder: (context) =>
                                      DeleteTaskDialog(todu: taskDetails),
                                ),
                              );
                            },
                          ),
                        ];
                      },
                    ),
                    dense: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTaskAlertDialog(todos);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
