import 'package:abdullah_mansour/modules/counter_simple_bloc_app/cubit/cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/states.dart';

class CounterScreen extends StatelessWidget {

  //int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state){
          // we'll use bloc observer it's better:
          // if(state is CounterMinusState) print('--------- rahi f minus -------');
          // if(state is CounterPlusState) print('--------- rahi f plus -------');
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "remove",
                    mini: true,
                    onPressed: () {
                      CounterCubit.get(context).minus();
                    },
                    child: Icon(Icons.remove, ),
                  ),
                  SizedBox(width: 30,),
                  Text(
                    "${CounterCubit.get(context).counter}",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 30,),
                  FloatingActionButton(
                    heroTag: "plus",
                    mini: true,
                    onPressed: () {
                      CounterCubit.get(context).plus();
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
