import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/screen_background.dart';
import 'package:task_management/UI/widgets/snackbar.dart';
import 'package:task_management/data/services/api_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text('Add new Task',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter title";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: descriptionController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter description";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addNewTask();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _clearFiels() {
    titleController.clear();
    descriptionController.clear();
  }

  bool _addTaskProgress = false;
  Future<void> addNewTask() async {
    setState(() {
      _addTaskProgress = true;
    });
    Map<String, dynamic> requestBody = {
      "title": titleController.text,
      "description": descriptionController.text,
      "status": "New",
    };
    final ApiResponse response =
        await ApiCaller.postRequest(url: Urls.createTask, body: requestBody);
    setState(() {
      _addTaskProgress = false;
    });
    if (response.isSuccess) {
      _clearFiels();
      showSnackBarMessage(context, 'New Task Added');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }
}
