import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/archived_screen/archived_tasks.dart';
import 'package:todo_app/Modules/done_screens/done_tasks.dart';
import 'package:todo_app/Modules/tasks_screen/new_tasks.dart';
import 'package:todo_app/Shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  final List screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];
  late Database database;
  List<Map> newTasks = [];
  List<Map> archivedTasks = [];
  List<Map> doneTasks = [];
  int itemIndex = 0;
  bool isBottomSheetShown = false;
  DateTime taskDate = DateTime.now();
  String formatedDate = "";
  TimeOfDay taskTime = TimeOfDay.now();
  String formatedTime = "";
  bool favIconPressed = false;

  void changeIndex(int index) {
    itemIndex = index;
    emit(AppBottomNavChangeScreen());
  }

  void createDatabase() {
    /*    deleteDatabase('toDo.db').then((value) {
      print("Database Deleted");
    }).catchError((onError) {
      print("Failed to delete database");
    });*/ //Delete Database

    openDatabase('toDo.db', version: 1, onCreate: (database, version) {
      print("Database Created");
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT,favourite TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error When Created Table! ${error.toString()}');
      }).then((value) {
        print("Database Created");
      }).catchError((error) {
        print('Error When Created Database! ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future insertToDatabase(
      {required String title,
      required String date,
      required String time}) async {
    return await database.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status,favourite) VALUES (\'$title\',\'$date\',\'$time\',\'new\',\'no\')');

      print('inserted ID: $id');
      getDataFromDatabase(database);
      emit(AppInsertDatabaseState());
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'archived') {
          archivedTasks.add(element);
        }
      }

      emit(AppGetDatabaseState());
    }).catchError((onError) {
      print('Error When Getting Data From Database! ${onError.toString()}');
    });
  }

  void updateDataFromDataBase({required id, String? status, String? favState}) {
    if (status != null) {
      database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
          [status, id.toString()]).then((value) {
        print("Record ${value.toString()} Updated Successfully");
        getDataFromDatabase(database);
      }).catchError((error) {
        print("Update Database Failed, ${error.toString()}");
      });
    } else if (favState != null) {
      database.rawUpdate('UPDATE tasks SET favourite = ? WHERE id = ?',
          [favState, id.toString()]).then((id) {
        print("Record ${id.toString()} Updated Successfully");
        getDataFromDatabase(database);
      }).catchError((error) {
        print("Update Database Failed, ${error.toString()}");
      });
    }
    emit(AppUpdateDatabaseState());
  }

  void deleteFromDatabase({required id}) async {
    database
        .rawDelete('DELETE FROM tasks WHERE id=?', [id.toString()])
        .then((value) => print("Record Deleted Successfully"))
        .catchError((error) {
          print("Failed To Delete The Record, ${error.toString()}");
        });
    emit(AppDeleteDatabaseState());
  }

  void changeBottomSheetState() {
    isBottomSheetShown = !isBottomSheetShown;
    emit(AppChangeBottomSheetState());
  }

  void changeDateSelectedState({date}) {
    if (date != "") {
      taskDate = date;
      formatedDate = DateFormat.yMMMd().format(taskDate);
    } else {
      formatedDate = "";
    }

    emit(AppDateSelectState());
  }

  void changeTimeSelectedState({required context, time}) {
    if (time != "") {
      taskTime = time;
      formatedTime = time!.format(context);
    } else {
      formatedTime = "";
    }

    emit(AppTimeSelectState());
  }

  var favIcon = Icon(
    Icons.star_border_outlined,
    color: Colors.white70,
  );
  void changeFavIconState({required id, required favState}) {
    if (favState == 'yes') {
      favIconPressed = false;
    } else {
      favIconPressed = true;
    }
    if (favIconPressed) {
      updateDataFromDataBase(id: id, favState: 'yes');
    } else {
      updateDataFromDataBase(id: id, favState: 'no');
    }
    emit(AppChangeFavIconState());
  }
}
