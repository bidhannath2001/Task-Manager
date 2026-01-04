import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/UI/screens/add_new_task_screen.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/shimmer_loading_widget.dart';
import 'package:task_management/UI/widgets/task_card.dart';
import 'package:task_management/UI/widgets/task_count_by_status.dart';
import 'package:task_management/core/enums/api_state.dart';
import 'package:task_management/providers/task_provider.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  Future<void> _loadData() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    await Future.wait([
      taskProvider.fetchTaskStatusCount(),
      taskProvider.fetchTaskByStatus('New')
    ]);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
        return Column(
          children: [
            taskProvider.taskCountState == ApiState.loading
                ? const ShimmerLoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 85,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: taskProvider.taskStatusCountList.length,
                        itemBuilder: (context, index) {
                          final counts = taskProvider.taskStatusCountList;
                          return TaskCountByStatus(
                            title: counts[index].status,
                            count: counts[index].count,
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
            Expanded(
              child: ListView.separated(
                itemCount: taskProvider.newTask.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: TaskCard(
                      taskModel: taskProvider.newTask[index],
                      chipColor: Colors.blue,
                      refreshtTaskList: () async {
                        await _loadData();
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
        );
      }),
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
