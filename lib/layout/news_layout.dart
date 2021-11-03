
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/Network/remote/DioHelper.dart';
import 'package:news_application/components/reusable_components.dart';
import 'package:news_application/modules/search/search.dart';
import 'package:news_application/shared/cubit/ModeCubit.dart';
import 'package:news_application/shared/cubit/States.dart';
import 'package:news_application/shared/cubit/cubit.dart';


class NewsLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
      builder: (BuildContext context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'News app',
            ),
            actions: [
              IconButton(onPressed: ()
              {
                NavigateTo(context, SearchScreen());
              },
                  icon: Icon(Icons.search)),
              IconButton(onPressed: ()
              {
                AppCubit.get(context).changeAppMode();
              },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],

          ),
          body: NewsAppCubit.get(context).Screens[NewsAppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsAppCubit.get(context).currentIndex,
            items: NewsAppCubit.get(context).barItems,
            onTap: (index)
            {
              NewsAppCubit.get(context).changeBottomBarState(index);
            },
          ),


        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }

}