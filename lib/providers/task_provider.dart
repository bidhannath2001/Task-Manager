import 'package:flutter/widgets.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/task_status_count_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> _newTask = [];
  List<TaskModel> _progressTask = [];
  List<TaskModel> _completedTask = [];
  List<TaskModel> _cancelledTask = [];

  List<TaskStatusCountModel> _taskStatusCountList = [];
  ApiState _taskListState = ApiState.initial;
  ApiState _taskCountState = ApiState.initial;

  String? _errorMessage;

  List<TaskModel> get newTask => _newTask;
  List<TaskModel> get progressTask => _progressTask;
  List<TaskModel> get completedTask => _completedTask;
  List<TaskModel> get cancelledTask => _cancelledTask;
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

  ApiState get taskListState => _taskListState;
  ApiState get taskCountState => _taskCountState;
  Future<void> fetchTaskStatusCount() async {
    _taskCountState = ApiState.loading;
    notifyListeners();
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      _taskStatusCountList.clear();
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        _taskStatusCountList.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskCountState = ApiState.success;
      _errorMessage = null;
    } else {
      _taskCountState = ApiState.error;
      _errorMessage =
          response.errorMessage ?? 'Failed to fetch task status count';
    }
    notifyListeners();
  }

  Future<void> fetchTaskByStatus(String status) async {
    _taskListState = ApiState.loading;
    notifyListeners();

    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.taskListUrl(status));

    List<TaskModel> list = [];
    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      switch (status) {
        case 'New':
          _newTask = list;
          break;
        case 'Progress':
          _progressTask = list;
          break;
        case 'Completed':
          _completedTask = list;
          break;
        case 'Cancelled':
          _cancelledTask = list;
          break;
        default:
          _newTask = list;
      }
      _taskListState = ApiState.success;
      _errorMessage = null;
    } else {
      _taskListState = ApiState.error;
      _errorMessage = response.errorMessage ?? 'Failed to fetch task list';
    }
    notifyListeners();
  }
}
