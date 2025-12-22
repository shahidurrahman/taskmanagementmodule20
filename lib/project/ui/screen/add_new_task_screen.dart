import 'package:flutter/material.dart';
import 'package:taskmanagement/project/data/services/api_caller.dart';
import 'package:taskmanagement/project/data/utils/urls.dart';
import 'package:taskmanagement/project/ui/weights/screen_background.dart';
import 'package:taskmanagement/project/ui/weights/snack_bar.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Titel'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter title';
                      }
              
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter description';
                      }
              
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addNewTask();
                      }
                    },
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _addTaskProgress = false;

  Future<void> addNewTask() async {
    _addTaskProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": titleController.text,
      "description": descriptionController.text,
      "status": "New",
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.createTaskUrl,
      body: requestBody,
    );

    _addTaskProgress = false;

    setState(() {});

    if (response.isSuccess) {
      _clearField();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/NavBar',
        (predicate) => false,
      );
      showSnackBarMessage(context, 'New task added');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  _clearField() {
    titleController.clear();
    descriptionController.clear();
  }
}
