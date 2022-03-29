
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_application/components/reusable_components.dart';
import 'package:news_application/shared/cubit/States.dart';
import 'package:news_application/shared/cubit/cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
              widgetBuilder: (context)=>SmartRefresher(
                controller: NewsAppCubit.get(context).scienceController,
                onRefresh: NewsAppCubit.get(context).onRefresh,
                onLoading: NewsAppCubit.get(context).onLoading,
                enablePullDown: true,
                enablePullUp: true,
                header:  MaterialClassicHeader(color: Colors.deepPurple,),
                footer: CustomFooter(
                  builder: (BuildContext context,LoadStatus? mode)
                  {
                    Widget body;
                    if(mode==LoadStatus.idle){
                      body =  Text("pull up load");
                    }
                    else if(mode==LoadStatus.loading){
                      body =  CupertinoActivityIndicator();
                    }
                    else if(mode == LoadStatus.failed){
                      body = Text("Load Failed!Click retry!");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = Text("release to load more");
                    }
                    else{
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child:body),
                    );
                  },
                ),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
                    separatorBuilder:(context,index)=> myDivider(),
                    itemCount: list.length
                ),
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