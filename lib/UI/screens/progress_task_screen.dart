import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_management/UI/widgets/banner_placeholder.dart';
import 'package:task_management/UI/widgets/content_placeholder.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/shimmer_loading_widget.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/UI/widgets/title_placeholder.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<TaskModel> _progressTaskList = [];
  bool _getprogressTaskProgress = false;

  Future<void> _getAllProgressTask() async {
    setState(() {
      _getprogressTaskProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskListUrl('Progress'));
    setState(() {
      _getprogressTaskProgress = false;
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
      _progressTaskList = list;
    });
  }

  @override
  initState() {
    super.initState();
    _getAllProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _getprogressTaskProgress == true
            ? ShimmerLoadingWidget()
            : ListView.separated(
                itemCount: _progressTaskList.length,
                itemBuilder: (context, index) => TaskCard(
                    taskModel: _progressTaskList[index],
                    chipColor: Colors.purple,
                    refreshtTaskList: () {
                      _getAllProgressTask();
                    }),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
              ),
      ),
    );
  }
}
