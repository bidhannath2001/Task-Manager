import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/screen_background.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Text('Add new Task', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 6,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {},
              child: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      )),
    );
  }
}
