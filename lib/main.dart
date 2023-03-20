import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Layouts/home_layout.dart';
import 'package:todo_app/Shared/bloc_observer.dart';
import 'package:todo_app/Shared/components/constants.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dialogTheme: DialogTheme(
            backgroundColor: secondColor,

            ),

        timePickerTheme: TimePickerThemeData(
          backgroundColor: secondColor,
          dialHandColor: defaultColor,
        dayPeriodTextColor: Colors.grey[600],hourMinuteTextColor: defaultColor),


      ),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
