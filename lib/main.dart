import 'package:flutter/material.dart';
import 'package:ucb_task_list/view/home.dart';
import 'package:ucb_task_list/view/login.dart';
import 'package:ucb_task_list/view/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final homeTitle = 'UCB Task List';
  final loginTitle = 'Welcome to UCB Task List App!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: homeTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      routes: {
        '/home': (context) => Home(title: homeTitle),
        '/login': (context) => Login(title: loginTitle),
      },
    );
  }
}
