
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_application/components/reusable_components.dart';
import 'package:news_application/shared/cubit/States.dart';
import 'package:news_application/shared/cubit/cubit.dart';

class ScienceScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit,NewsAppStates>(
        builder: (context,state)
        {
          var list=NewsAppCubit.get(context).science;
          return Conditional.single(
              context: context,
              conditionBuilder: (context)=>list.length>0,
              widgetBuilder: (context)=>ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildArticleItem(list[index],context),
                  separatorBuilder:(context,index)=> myDivider(),
                  itemCount: list.length
              ),
              fallbackBuilder: (context)=>Center(child: CircularProgressIndicator())
          );
        },
        listener:(context,state)
        {

        }
    );
  }

}