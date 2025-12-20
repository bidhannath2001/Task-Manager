import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool _getCompletedTaskProgress = false;

  Future<void> _getAllCompletedTask() async {
    setState(() {
      _getCompletedTaskProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskListUrl('Completed'));
    setState(() {
      _getCompletedTaskProgress = false;
    });
    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    setState(() {
      _completedTaskList = list;
    });
  }

  @override
  initState() {
    super.initState();
    _getAllCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Visibility(
          visible: _getCompletedTaskProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _completedTaskList.length,
            itemBuilder: (context, index) => TaskCard(
                taskModel: _completedTaskList[index],
                chipColor: Colors.green,
                refreshtTaskList: () {
                  _getAllCompletedTask();
                }),
            separatorBuilder: (context, index) => const SizedBox(
              height: 4,
            ),
          ),
        ),
      ),
    );
  }
}
