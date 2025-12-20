import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  List<TaskModel> _cancelledTaskList = [];
  bool _getCancelledTaskProgress = false;

  Future<void> _getAllCancelledTask() async {
    setState(() {
      _getCancelledTaskProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskListUrl('Cancelled'));
    setState(() {
      _getCancelledTaskProgress = false;
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
      _cancelledTaskList = list;
    });
  }

  @override
  initState() {
    super.initState();
    _getAllCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Visibility(
          visible: _getCancelledTaskProgress == false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: _cancelledTaskList.length,
            itemBuilder: (context, index) => TaskCard(
                taskModel: _cancelledTaskList[index],
                chipColor: Colors.red,
                refreshtTaskList: () {
                  _getAllCancelledTask();
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
