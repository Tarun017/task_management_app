import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  HomeScreen();

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
        ),
        actions: [
          Row(
            children: [
              const Text(
                'sync',
              ),
              CupertinoSwitch(
                value:screenModel.offlineMode,
                onChanged: (value) async {
                  screenModel.toggleMode();
                  if(!screenModel.offlineMode){
                    final todoModel = Provider.of<TodoModel>(context,listen: false);
                    final todos = todoModel.todoBox;
                    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
                    tasks.get()
                        .then((QuerySnapshot querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                       for (int index = 0; index < todos.length; index++) {
                         if( doc["id"]!=todos[index].id){
                          tasks.add({
                            'id': todos[index].id,
                            'title': todos[index].title,
                            'taskDesc': todos[index].taskDesc,
                          },);}                  }
                      });
                    });



                  }
                },
              ),
            ],
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            final taskDetails = todos[index];
            return  Container(
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
                leading: Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.amber,
                  ),
                ),
                title: Text(taskDetails.title),
                subtitle: Text(taskDetails.taskDesc),
                isThreeLine: true,
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
                              builder: (context) => UpdateTaskAlertDialog(todu: taskDetails,),
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
                        onTap: (){
                          int taskId = taskDetails.id;
                          String taskName = taskDetails.title;
                          Future.delayed(
                            const Duration(seconds: 0),
                                () => showDialog(
                              context: context,
                              builder: (context) => DeleteTaskDialog(todu:taskDetails),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return  AddTaskAlertDialog(todos);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
