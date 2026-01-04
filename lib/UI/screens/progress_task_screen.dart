import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/shimmer_loading_widget.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/core/enums/api_state.dart';

import 'package:task_management/providers/task_provider.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  Future<void> _getAllProgressTask() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchTaskByStatus('Progress');
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
        child: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
          return taskProvider.taskListState == ApiState.loading
              ? const ShimmerLoadingWidget()
              : ListView.separated(
                  itemCount: taskProvider.progressTask.length,
                  itemBuilder: (context, index) => TaskCard(
                      taskModel: taskProvider.progressTask[index],
                      chipColor: Colors.purple,
                      refreshtTaskList: () {
                        _getAllProgressTask();
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
