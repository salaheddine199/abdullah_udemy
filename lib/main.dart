import 'package:abdullah_mansour/layout/new_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/new_app/cubit/states.dart';
import 'package:abdullah_mansour/layout/shop_app/shop_layout.dart';
import 'package:abdullah_mansour/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdullah_mansour/shared/bloc_observer.dart';
import 'package:abdullah_mansour/shared/components/constants.dart';
import 'package:abdullah_mansour/shared/network/local/cache_helper.dart';
import 'package:abdullah_mansour/shared/network/remote/dio_helper.dart';
import 'package:abdullah_mansour/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/states.dart';
import 'modules/shop_app/on_boarding_screen.dart';

/// shop app:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getDarkMode();
  bool isOnBoarding = (CacheHelper.getData(key: 'isOnBoarding'))?? true; // First time should be on boarding screen
  token = (CacheHelper.getData(key: 'loginToken')?? '' );
   //print('is it dark mode: $isDark');
   //print(' is it on boarding scree: $isOnBoarding');
   print('Main: token: $token');
  Widget startWidget;

  if(isOnBoarding) startWidget = OnBoardingScreen();
  else{
    if(token.isEmpty) startWidget = ShopLoginScreen(); // loginToken
    else startWidget = ShopLayout();
  }

  runApp(OurApp(
    startWidget: startWidget,
      isDark: isDark,
  ));
}

class OurApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  const OurApp({Key key, this.startWidget, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return ShopCubit()..getHomeData()..getCategories()..getFavorites()..getProfile(); },
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Abdullah Mansour Course',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark //ThemeMode.system,
                ?ThemeMode.dark
                :ThemeMode.light,
            home:  startWidget, //isOnBoarding? OnBoardingScreen() : ShopLoginScreen(),
            // todo change the methods in DIO class

          );
        },
      ),
    );
  }
}

/// news app :
/*
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
              home:  NewsLayout() /// todo change the methods in DIO class

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
*/

///to do app
/*

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