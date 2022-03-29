
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/Network/remote/DioHelper.dart';
import 'package:news_application/modules/bussiness/businessScreen.dart';
import 'package:news_application/modules/science/scienceScreen.dart';
import 'package:news_application/modules/sports/sportsScreen.dart';
import 'package:news_application/shared/cubit/States.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsAppCubit extends Cubit<NewsAppStates> {
  NewsAppCubit() : super(NewsAppIntialState());

  static NewsAppCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget>Screens=
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];

  List<BottomNavigationBarItem> barItems=
  [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.business
      ),
      label: 'Business'
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.sports
      ),
      label: 'Sports'
      ),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.science
      ),
      label: 'Science'
      ),

  ];

  void changeBottomBarState (int index)
  {
    currentIndex=index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());

  }

  List<dynamic> business=[];
  List<dynamic> sports=[];
  List<dynamic> science=[];

  void getbusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines' ,
      query:{
        'county':'eg',
        'category':'business',
        'apikey':'1a55369415b240ba815d3df7ced7b02f',
      },
    ).then((value){
     // print(value.data['articles'][0]['title']);
      business=value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());

    }).catchError((error){
      print(error.toString());

      emit(NewsGetBusinesErrorState(error.toString()));

      //return Completer<Never>().future;

    });
  }

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines' ,
        query:{
          'county':'eg',
          'category':'sports',
          'apikey':'1a55369415b240ba815d3df7ced7b02f',
        },
      ).then((value){
        // print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
        //return Completer<Never>().future;
      });

    }else
      {
        emit(NewsGetSportsSuccessState());
      }


  }

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length==0)
    {
      DioHelper.getData(
        url: 'v2/top-headlines' ,
        query:{
          'county':'eg',
          'category':'science',
          'apikey':'1a55369415b240ba815d3df7ced7b02f',
        },
      ).then((value){
        // print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());

      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
        return Completer<Never>().future;
      });

    }else
      {
        emit(NewsGetScienceSuccessState());
      }


  }

  // void getScience() {
  //   emit(NewsGetScienceLoadingState());
  //
  //   if (science.length > 0) {
  //     DioHelper.getData(
  //         url: 'v2/top-headlines',
  //         query: {
  //           'county': 'eg',
  //           'category': 'science',
  //           'apikey': '1a55369415b240ba815d3df7ced7b02f',
  //         }
  //     ).then((value) {
  //        print(value.data['articles'][0]['title']);
  //       science = value.data['articles'];
  //       print(science[0]['title']);
  //
  //       emit(NewsGetScienceSuccessState());
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(NewsGetScienceErrorState(error.toString()));
  //       return Completer<Never>().future;
  //     });
  //      }else
  //      {
  //       emit(NewsGetScienceSuccessState());
  //      }
  //
  //
  //   }


    List <dynamic> search = [];
    void getSearch(String value) {
      if(value !='')
        {
          emit(NewsGetSearchLoadingState());

          DioHelper.getData(
            url: 'v2/everything',
            query: {
              'q': '$value',
              'apikey': '1a55369415b240ba815d3df7ced7b02f',
            },
          ).then((value) {
            // print(value.data['articles'][0]['title']);
            search = value.data['articles'];
            //print(search[0]['title']);

            emit(NewsGetSearchSuccessState());
          }).catchError((error) {
            print(error.toString());

            emit(NewsGetSearchErrorState(error.toString()));
            return Completer<Never>().future;
          });
        }
      else{
        search=[];
        emit(NewsGetSearchSuccessState());
      }

    }

  RefreshController businessController =
  RefreshController(initialRefresh: false);

    RefreshController scienceController =
  RefreshController(initialRefresh: false);

    RefreshController sportsController =
  RefreshController(initialRefresh: false);

  Future<void> onRefresh()async
  {
    Future.delayed(Duration(seconds: 1));
    if(currentIndex==0){
      business=[];
      getbusiness();
      emit(NewsRefreshBusinessSuccessState());
      businessController.refreshCompleted();
    } else if(currentIndex==1){
      sports=[];
      getSports();
      emit(NewsRefreshSportsSuccessState());
      sportsController.refreshCompleted();
    }else if(currentIndex==2){
      science=[];
      getScience();
      emit(NewsRefreshScienceSuccessState());
      scienceController.refreshCompleted();
    }
  }

  void onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));

    if(currentIndex==0){
      businessController.requestLoading();
    } else if(currentIndex==1){
      sportsController.requestLoading();

    }else if(currentIndex==2){
      scienceController.requestLoading();
    }
  }


}
