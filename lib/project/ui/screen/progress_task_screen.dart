import 'package:flutter/material.dart';
import 'package:taskmanagement/project/data/models/task_model.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/weights/snack_bar.dart';
import 'package:taskmanagement/project/ui/weights/task_card.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<TaskModel> _progressTaskList = [];
  bool _getprogressTaskProgress = false;

  Future<void> _getAllTasks() async {
    _getprogressTaskProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.progressTaskUrl,
    );

    _getprogressTaskProgress = false;
    setState(() {});
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    _progressTaskList = list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Visibility(
          visible: _getprogressTaskProgress == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: _progressTaskList[index],
                cardColor: Colors.blue,
                refreshParent: () {
                  _getAllTasks();
                },
              );
            },

            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
          ),
        ),
      ),
    );
  }
}
