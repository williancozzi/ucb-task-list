import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ucb_task_list/controller/home_controller.dart';
import 'package:ucb_task_list/model/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget(
      {Key key,
      this.task,
      this.onClickRemoveTask,
      this.onClickTask,
      this.controller})
      : super(key: key);

  final Task task;
  final Function onClickRemoveTask;
  final Function onClickTask;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListTile(
          title: Text(task.title),
          subtitle: task.description.isEmpty || task.description == null
              ? null
              : Text("${task.description}\n${task.deadlineString}"),
          leading: Checkbox(
              value: task.check,
              onChanged: (value) {
                controller.checkTask(task, value);
              }),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            iconSize: 30.0,
            onPressed: onClickRemoveTask,
          ),
          onTap: onClickTask,
        );
      },
    );
  }
}
