import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ucb_task_list/view/components/date_time_widget.dart';
import 'package:ucb_task_list/view/components/task_widget.dart';
import 'package:ucb_task_list/controller/home_controller.dart';
import 'package:ucb_task_list/model/task.dart';

enum Opcao { add, update }

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    controller.getNomeSP();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.panorama_fish_eye),
                text: "To do",
              ),
              Tab(
                icon: Icon(Icons.check_circle),
                text: "Done",
              ),
            ],
          ),
          title: Observer(builder: (_) {
            return Text("${controller.nomeUsuario} tasks:");
          }),
          // automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              _pendentes(),
              _concluidos(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add new task"),
          onPressed: (() => _dialogoNovaTask(null)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _pendentes() {
    var tasks = controller.pendentes;
    controller.getListaSP();
    return Observer(
      builder: (_) {
        return ListView.builder(
            itemCount: tasks().length,
            itemBuilder: (_, i) {
              var task = tasks()[i];
              return TaskWidget(
                task: task,
                onClickRemoveTask: () {
                  // controller.removeTask(task);
                  _alertaRemoverTask(task);
                },
                onClickTask: () {
                  _dialogoNovaTask(task);
                },
                controller: controller,
              );
            });
      },
    );
  }

  _concluidos() {
    var concluidos = controller.concluidos;
    controller.getListaSP();
    return Observer(
      builder: (_) {
        return ListView.builder(
            itemCount: concluidos().length,
            itemBuilder: (_, i) {
              var task = concluidos()[i];
              return TaskWidget(
                task: task,
                onClickRemoveTask: () {
                  // controller.removeTask(task);
                  _alertaRemoverTask(task);
                },
                onClickTask: () {
                  _dialogoNovaTask(task);
                },
                controller: controller,
              );
            });
      },
    );
  }

  _alertaRemoverTask(Task task) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Do you want to delete the task: \"${task.title}\"?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              FlatButton(
                  onPressed: () {
                    controller.removeTask(task);
                    Navigator.pop(context);
                  },
                  child: Text("Delete")),
            ],
          );
        });
  }

  _dialogoNovaTask(Task task) {
    Opcao opcao;

    if (task == null) {
      task = Task(deadline: DateTime.now());
      opcao = Opcao.add;
    } else {
      opcao = Opcao.update;
    }

    var title = opcao == Opcao.add ? "New Task" : "Edit Task";

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              width: 300,
              height: 230,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: task.title,
                    onChanged: task.setTitle,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Title"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: task.description,
                    onChanged: task.setDescription,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Description"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeWidget(task: task),
                ],
              ),
            ),
            actions: _actions(opcao, task),
          );
        });
  }

  _actions(Opcao opcao, Task task) {
    if (opcao == Opcao.add) {
      return [
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            if (opcao == Opcao.add) {
              controller.addTask(task);
            } else {
              controller.updateTask(task);
            }
            Navigator.pop(context);
          },
        ),
      ];
    } else {
      return [
        FlatButton(
          child: Text("Done"),
          onPressed: () {
            controller.salvarListaSP();
            Navigator.pop(context);
          },
        ),
      ];
    }
  }
}
