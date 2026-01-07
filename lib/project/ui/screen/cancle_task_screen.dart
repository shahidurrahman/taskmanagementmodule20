import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/project/ui/weights/task_card.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';
import 'package:taskmanagement/providers/task_provider.dart';

class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future <void> loadData()async {
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    Future.wait([
      taskProvider.fetchNewTaskByStatus('Cancelled'),
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
                itemCount: taskProvider.cancelledTasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskModel: taskProvider.cancelledTasks[index],
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
