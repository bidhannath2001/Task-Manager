import 'package:flutter/material.dart';
import 'package:task_management/UI/screens/add_new_task_screen.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/UI/widgets/task_count_by_status.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/task_status_count_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountProgress = false;
  bool _getNewTaskProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  Future<void> _getTaskStatusCount() async {
    setState(() {
      _getTaskStatusCountProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskStatusCount);
    setState(() {
      _getTaskStatusCountProgress = false;
    });
    List<TaskStatusCountModel> list = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
    setState(() {
      _taskStatusCountList = list;
    });
  }

  Future<void> _getAllNewTask() async {
    setState(() {
      _getNewTaskProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskListUrl('New'));
    setState(() {
      _getNewTaskProgress = false;
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
      _newTaskList = list;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTaskStatusCount();
    _getAllNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 85,
              child: Visibility(
                visible: _getTaskStatusCountProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _taskStatusCountList.length,
                  itemBuilder: (context, index) {
                    return TaskCountByStatus(
                      title: _taskStatusCountList[index].status,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 4,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _newTaskList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: TaskCard(
                    taskModel: _newTaskList[index],
                    chipColor: Colors.blue,
                    refreshtTaskList: () {
                      _getAllNewTask();
                      _getTaskStatusCount();
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 5,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNewTaskScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
