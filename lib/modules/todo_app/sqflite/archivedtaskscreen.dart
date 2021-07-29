
import 'package:abdullah_mansour/layout/todo_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/todo_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTaskScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, state){

        var tasks = AppCubit.get(context).archivedTasks;

        return taskBuilder(tasks: tasks);
        },
    );
  }

}
