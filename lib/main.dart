import 'package:abdullah_mansour/layout/new_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/shop_app/on_boarding_screen.dart';
import 'package:abdullah_mansour/shared/bloc_observer.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:abdullah_mansour/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/new_app/news_layout.dart';

// news app || shop app:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  runApp(OurApp());
}

class OurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Mansour used two providers cuz he used TodoCubit to work with darkmode
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness(),// u can call them all here
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state){
          //print('---- night mode is : ${CacheHelper.getDarkMode()}');
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Abdullah Mansour Course',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: CacheHelper.getDarkMode() //ThemeMode.system,
                  ?ThemeMode.dark
                  :ThemeMode.light,
              home: OnBoardingScreen(),//NewsLayout()
            // Directionality(
            //   child: NewsLayout(),
            //   textDirection: TextDirection.rtl,
            // ),
          );
        },
      ),
    );
  }
}


/*

 //to do app

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(OurApp());
}

class OurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Abdullah Mansour Course',
        home:
              TodoLayout(),
              //MyHomePage(title: 'Abdullah Course'),
              //LoginScreen(),
              //CounterScreen(), // simple bloc test

    );
  }
}
*/