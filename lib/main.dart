import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_application/Network/local/cachHelper.dart';
import 'package:news_application/Network/remote/DioHelper.dart';
//import 'package:news_application/layout/news_layout.dart';
import 'package:news_application/shared/cubit/ModeCubit.dart';
import 'package:news_application/shared/cubit/ModeStates.dart';
//import 'package:news_application/shared/cubit/States.dart';
import 'package:news_application/shared/cubit/cubit.dart';

import 'bloc_observer.dart';
import 'modules/splashScreen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer=MyBlocObserver();
  DioHelper.Init();
  await cacheHelper.init();

  bool? isDark = cacheHelper.getBoolean(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool? isDark;

   MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider
      (
      providers: [
        BlocProvider(create: (context)=>NewsAppCubit()..getbusiness()..getSports()..getScience()),
        BlocProvider(create: ( BuildContext context)=> AppCubit()..changeAppMode(fromShared: isDark,))
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                        color:Colors. black
                    )
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepPurple
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepPurple,
                    backgroundColor: Colors.white
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                )

            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepPurple,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light
                    ),
                    backgroundColor: HexColor('333739'),
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                        color:Colors. white
                    )

                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepPurple
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepPurple,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: HexColor('333739')
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: splashScreen(),

          );
        },
      ),
    );
  }
}
