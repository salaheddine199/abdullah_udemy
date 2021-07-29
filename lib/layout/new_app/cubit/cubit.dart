import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/news_app/business/business_screen.dart';
import 'package:abdullah_mansour/modules/news_app/science/science_screen.dart';
import 'package:abdullah_mansour/modules/news_app/sports/sports_screen.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  // bottom navigation bar:

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business,),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_soccer_rounded,),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science,),
      label: 'Science',
    ),
  ];

  List<Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeNavBar(index){
    currentIndex = index;
    if(index == 1)
      getSports();
    else if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  // news app screens:

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'8b3e7868e39f43bfac1b573453b69380',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      //print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];
  void getSports(){

    emit(NewsGetSportsLoadingState());

    if(sports.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'8b3e7868e39f43bfac1b573453b69380',
        },
      ).then((value) {

        sports = value.data['articles'];
        //print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessState());
    }


  }


  List<dynamic> science = [];
  void getScience(){

    emit(NewsGetScienceLoadingState());

    if(science.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'8b3e7868e39f43bfac1b573453b69380',
        },
      ).then((value) {

        science = value.data['articles'];
        //print(science[0]['title']);

        emit(NewsGetScienceSuccessState());

      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic> search = [];
  void getSearch(String value){

    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'8b3e7868e39f43bfac1b573453b69380',
      },
    ).then((value) {

      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }


  // night mode:

  void changeAppMode(){
    bool isDark = CacheHelper.getDarkMode();

    CacheHelper.setDarkMode(value: !isDark).then((value) {

      emit(NewsChangeModeState());

    });

  }




}