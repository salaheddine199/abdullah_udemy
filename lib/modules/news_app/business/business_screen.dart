import 'package:abdullah_mansour/layout/new_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {

        List list = NewsCubit.get(context).business;
        return articleBuilder(list, context);
      },
    );
  }
}
