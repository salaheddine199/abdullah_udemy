import 'package:abdullah_mansour/layout/new_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/modules/counter_simple_bloc_app/counter_screen.dart';
import 'package:abdullah_mansour/shared/bloc_observer.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'layout/new_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';


// news app
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
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                //primaryColor: Colors.blue[200],
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,// so we can control status bar style
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  bodyText2: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                //primaryColor: Colors.blue[200],
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  backwardsCompatibility: false,// so we can control status bar style
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  bodyText2: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              themeMode: CacheHelper.getDarkMode() //ThemeMode.system,
                  ?ThemeMode.dark
                  :ThemeMode.light,
              home: NewsLayout()
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
