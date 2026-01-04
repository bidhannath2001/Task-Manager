import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/shimmer_loading_widget.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/providers/task_provider.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  Future<void> _getAllCancelledTask() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchTaskByStatus('Cancelled');
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
        child: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
          return taskProvider.taskListState == ApiState.loading
              ? ShimmerLoadingWidget()
              : ListView.separated(
                  itemCount: taskProvider.cancelledTask.length,
                  itemBuilder: (context, index) => TaskCard(
                      taskModel: taskProvider.cancelledTask[index],
                      chipColor: Colors.red,
                      refreshtTaskList: () {
                        _getAllCancelledTask();
                      }),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 4,
                  ),
                );
        }),
      ),
    );
  }
}
