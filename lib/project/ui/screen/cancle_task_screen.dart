import 'package:flutter/material.dart';
import 'package:taskmanagement/project/ui/weights/task_card.dart';
import 'package:taskmanagement/project/ui/weights/tm_app_bar.dart';

class CancleTaskScreen extends StatefulWidget {
  const CancleTaskScreen({super.key});

  @override
  State<CancleTaskScreen> createState() => _CancleTaskScreenState();
}

class _CancleTaskScreenState extends State<CancleTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
          itemBuilder: (context, index) {
           // return TaskCard(status: 'Canceled', cardColor: Colors.red );
          },

          separatorBuilder: (context, index) {
            return SizedBox(height: 2);
          },

          itemCount: 10,
        ),
      ),
    );
  }
}
