import 'package:flutter/material.dart';
import 'package:task_management/UI/widgets/custom_appbar.dart';
import 'package:task_management/UI/widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) => const TaskCard(
              status: "Completed",
              chipColor: Colors.green,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 4,
            ),
          ),
        ),
    );
  }
}
