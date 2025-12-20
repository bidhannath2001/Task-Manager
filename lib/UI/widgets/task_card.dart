// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class TaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final Color chipColor;
  final VoidCallback refreshtTaskList;
  const TaskCard({
    Key? key,
    required this.taskModel,
    required this.chipColor,
    required this.refreshtTaskList,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;
  bool _deleteInProgress = false;
  Future<void> _changeStatus(String status) async {
    setState(() {
      _changeStatusInProgress = true;
    });
    final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.changeStatus(widget.taskModel.id, status));
    setState(() {
      _changeStatusInProgress = false;
    });
    if (response.isSuccess) {
      Navigator.pop(context);
      widget.refreshtTaskList();
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
  }

  Future<void> _deleteTask() async {
    setState(() {
      _deleteInProgress = true;
    });
    final ApiResponse response =
        await ApiCaller.getRequest(url: Urls.deleteUrl(widget.taskModel.id));
    setState(() {
      _deleteInProgress = false;
    });
    if (response.isSuccess) {
      widget.refreshtTaskList();
      showSnackBarMessage(context, "Task is deleted successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showChangeStatusDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Change Status"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      _changeStatus('New');
                    },
                    title: const Text("New"),
                    trailing: widget.taskModel.status == "New"
                        ? const Icon(Icons.done, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    onTap: () {
                      _changeStatus('Progress');
                    },
                    title: const Text("Progress"),
                    trailing: widget.taskModel.status == "Progress"
                        ? const Icon(Icons.done, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    onTap: () {
                      _changeStatus('Completed');
                    },
                    title: const Text("Completed"),
                    trailing: widget.taskModel.status == "Completed"
                        ? const Icon(Icons.done, color: Colors.green)
                        : null,
                  ),
                  ListTile(
                    onTap: () {
                      _changeStatus("Cancelled");
                    },
                    title: const Text("Cancelled"),
                    trailing: widget.taskModel.status == "Cancelled"
                        ? const Icon(Icons.done, color: Colors.green)
                        : null,
                  ),
                ],
              ),
            );
          });
    }

    return Card(
      elevation: 2,
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "${widget.taskModel.title}",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.taskModel.description}"),
            Text("${widget.taskModel.createdDate}"),
            Row(
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  side: const BorderSide(style: BorderStyle.none),
                  backgroundColor: widget.chipColor,
                  label: Text(widget.taskModel.status),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showChangeStatusDialog();
                  },
                  icon: const Icon(Icons.edit_note),
                  color: Colors.green,
                ),
                IconButton(
                    onPressed: () {
                      _deleteTask();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
