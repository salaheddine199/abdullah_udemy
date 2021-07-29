import 'package:abdullah_mansour/modules/counter_simple_bloc_app/cubit/states.dart';
import 'package:bloc/bloc.dart'; // not necessary  I think
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>{

  // constructor to set the initial state
  CounterCubit() : super(CounterInitialState());

  // method than returns an obj of this class
  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void minus(){
    counter--;
    emit(CounterMinusState());
  }

  void plus(){
    counter++;
    emit(CounterPlusState());
  }

}