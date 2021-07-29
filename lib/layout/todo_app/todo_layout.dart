import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class TodoLayout extends StatelessWidget {
  //FocusNode focusNode = new FocusNode();

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var _titleController = TextEditingController();
  var _timeController = TextEditingController();
  var _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
            /*
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Inserted Successfully'),
                backgroundColor: Colors.lightBlueAccent,
                duration: const Duration(
                  seconds: 1,
                ),
              ),
            );
             */
          }
          if (state is AppDeleteDatabaseState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Deleted Successfully'),
                backgroundColor: Colors.lightBlueAccent,
                duration: const Duration(
                  seconds: 1,
                ),
              ),
            );
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              titleSpacing: 20.0,
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              //true, // tasks.length > 0,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (_formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                      title: _titleController.text,
                      time: _timeController.text,
                      date: _dateController.text,
                    );
                  }
                } else {
                  cubit.changeBottomSheet(icon: Icons.add, isShow: true);

                  _scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  validFun: (String value) {
                                    if (value.isEmpty)
                                      return 'title must not be empty';
                                    return null;
                                  },
                                  text: "Task Title",
                                  keyBoardType: TextInputType.text,
                                  controller: _titleController,
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  onlyRead: true,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      _timeController.text =
                                          value.format(context).toString();
                                      //print(value.format(context));
                                    });
                                  },
                                  validFun: (String value) {
                                    if (value.isEmpty)
                                      return 'time must not be empty';
                                    return null;
                                  },
                                  text: "Task Time",
                                  keyBoardType: TextInputType.datetime,
                                  controller: _timeController,
                                  prefix: Icons.watch_later_rounded,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                  onlyRead: true,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(
                                          2025), //parse("2021-12-00"),
                                    ).then((value) {
                                      _dateController.text = DateFormat.yMMMd()
                                          .format(value)
                                          .toString();
                                    });
                                  },
                                  validFun: (String value) {
                                    if (value.isEmpty)
                                      return 'date must not be empty';
                                    return null;
                                  },
                                  text: "Task Date",
                                  keyBoardType: TextInputType.datetime,
                                  controller: _dateController,
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 25.0,
                      )
                      .closed
                      .then((value) {
                    //closeBottomSheet();
                    cubit.changeBottomSheet(icon: Icons.edit, isShow: false);

                    _titleController.clear();
                    _dateController.clear();
                    _timeController.clear();
                  });
                }

                // here we try to understand a little of Async Await Futures
                /*
            // here we need to set the scope to async
            try{
              var name = await getName();
              print(name);
              print("this text can execute before our name!!!");
              throw("Some Error hhh");
            }
            catch(error){
              print("error is ${error.toString()}");
            }*/
                /*
            // in this case no need to ASYNC, AWAIT:
            getName().then((value) {

              print(value);
              print("this text will never execute before our name cuz it's ready");

              throw("Some Error hhh");
            }).catchError((error) {
              print("The error is ${error.toString()}");
            });
            */
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              //type: BottomNavigationBarType.fixed,
              //backgroundColor: Colors.blue,
              //elevation: 10,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

/*
  // future async await : simple explanation:
  Future<String> getName() async{
    return "Salah Eddine";
  }*/

}

// 1. create database
// 2. create tables
// 3. open database
// 4. insert to database
// 5. get from database
// 6. update in database
// 7. delete from database
