import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/data/models/task_model.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/weights/snack_bar.dart';
import 'package:taskmanagement/project/ui/weights/task_card.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';
import 'package:taskmanagement/providers/task_provider.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  Future <void> loadData()async {
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    Future.wait([
      taskProvider.fetchNewTaskByStatus('Progress'),
    ]);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Consumer<TaskProvider>(
          builder: (context,taskProvider,child){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                itemCount: taskProvider.progressTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: taskProvider.progressTasks[index],
                    cardColor: Colors.blue,
                    refreshParent: (){
                      loadData();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 4,
                  );
                },
              ),
            );
          }
      ),
    );
  }
}
