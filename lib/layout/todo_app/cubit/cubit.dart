import 'package:abdullah_mansour/modules/todo_app/sqflite/archivedtaskscreen.dart';
import 'package:abdullah_mansour/modules/todo_app/sqflite/donetaskscreen.dart';
import 'package:abdullah_mansour/modules/todo_app/sqflite/newtaskscreen.dart';

import 'package:abdullah_mansour/layout/todo_app/cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarIndexState());
  }


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    @required IconData icon,
    @required bool isShow,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  // DATABASE:
  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    // var dbPath = await getDatabasesPath();
    // String path = dbPath + "ourDatabase.db";
    // print(path);
    String query = '''CREATE TABLE tasks 
                            (   id INTEGER PRIMARY KEY, 
                                title TEXT,
                                date TEXT,
                                time TEXT,
                                status TEXT
                            )''';

    openDatabase('firstDatabase.db', version: 1, onCreate: (database, version) {
      print('database created');
      database.execute(query).then((value) {
        print('table created');
      }).catchError((error) {
        print('error while creating table: ${error.toString()}');
      });
    }, onOpen: (database) {

      getFromDatabase(database);

      print('database opened');

    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String date,
    @required String time,
    //@required String status,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES ("$title", "$date","$time","new")')
          .then((value) {
        print('$value : inserted successfully');
        emit(AppInsertDatabaseState());

        getFromDatabase(database);
      }).catchError((error) =>
              print('error while inserting a new raw : ${error.toString()}'));
      return null;
    });
  }

  void getFromDatabase(database) {
    emit(AppGetDatabaseLoadingState());
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {
      //tasks = value;
      //print('from opening db method, tasks: $tasks');

      value.forEach((element) {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] =='done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);

      });

      emit(AppGetDatabaseState());
    }).catchError((error) =>
        print('error while getting data from db : ${error.toString()}'));;
  }

  void updateDatabase({
    @required String status,
    @required int id,
}) async{
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [ '$status', id ],
    ).then((value) {



      emit(AppUpdateDatabaseState());
      getFromDatabase(database);
    });
  }


  void deleteFromDatabase({
    @required int id,
  }) async{
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    )
        .then((value) {

          emit(AppDeleteDatabaseState());
          getFromDatabase(database);

    });
  }





}
