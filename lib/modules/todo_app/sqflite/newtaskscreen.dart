import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // if we didn't set the BlocConsumer; it works but we need to do ctrl+s
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){

        var tasks = AppCubit.get(context).newTasks;

        return taskBuilder(tasks: tasks);
      },
    );
  }

}

