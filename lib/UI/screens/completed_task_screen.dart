import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/shimmer_loading_widget.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/providers/task_provider.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  Future<void> _getAllCompletedTask() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await taskProvider.fetchTaskByStatus('Completed');
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
        child: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
          return taskProvider.taskListState == ApiState.loading
              ? ShimmerLoadingWidget()
              : ListView.separated(
                  itemCount: taskProvider.completedTask.length,
                  itemBuilder: (context, index) => TaskCard(
                      taskModel: taskProvider.completedTask[index],
                      chipColor: Colors.green,
                      refreshtTaskList: () {
                        _getAllCompletedTask();
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
